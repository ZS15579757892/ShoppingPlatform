import random
import time

from django.http import FileResponse
from django.shortcuts import render
import os
from rest_framework import status, mixins
from rest_framework.response import Response
from rest_framework.throttling import AnonRateThrottle
from rest_framework.views import APIView
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import AllowAny
from rest_framework.viewsets import GenericViewSet
from rest_framework.permissions import IsAuthenticated

from ShoppingPlatform.settings import MEDIA_ROOT
from common.aliyunMessage import AliyunSMS
from users.models import User, Addr, VerifCode
from . import permissions
from .permissions import AddrPermission
from .serializers import UserSerializer, AddrSerializer

import re


# Create your views here.
class RegisterView(APIView):
    """注册"""

    # permission_classes = [AllowAny]
    # authentication_classes = []

    def post(self, request):
        # 1.接受用户参数
        username = request.data.get('username')
        password = request.data.get('password')
        email = request.data.get('email')
        password_confirmation = request.data.get('password_confirmation')
        # 2.参数校验
        if not all([username, password, email, password_confirmation]):
            return Response({'error': '所有参数不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if User.objects.filter(username=username).exists():
            return Response({'error': '用户已存在'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if password != password_confirmation:
            return Response({'error': '两次密码不一致'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not 6 <= len(password) < 18:
            return Response({'error': '密码长度需要在6到18位之间'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if User.objects.filter(email=email).exists():
            return Response({'error': '该邮箱已被注册'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not re.match(r'^[a-z0-9][\w./-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return Response({'error': '邮箱格式不正确'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 3.创建用户
        obj = User.objects.create_user(username=username, email=email, password=password)
        res = {
            "username": username,
            "id": obj.id,
            'email': obj.email
        }
        return Response(res, status=status.HTTP_201_CREATED)


class LoginView(TokenObtainPairView):
    """自定义用户登录"""

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])
        result = serializer.validated_data
        result['id'] = serializer.user.id
        result['mobile'] = serializer.user.mobile
        result['email'] = serializer.user.email
        result['username'] = serializer.user.username
        result['token'] = result.pop('access')

        return Response(serializer.validated_data, status=status.HTTP_200_OK)


class UserView(GenericViewSet, mixins.RetrieveModelMixin):
    """用户相关操作的视图集"""
    queryset = User.objects.all()
    serializer_class = UserSerializer
    # 设置认证方式
    permission_classes = [IsAuthenticated, permissions.UserPermission]

    def upload_avatar(self, request, *args, **kwargs):
        """上传用户头像"""
        avatar = request.data.get('avatar')
        # 参数校验
        if not avatar:
            return Response({'error': '上传失败，文件不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # if avatar.size < 1024*300:
        #     return Response({'error': '上传失败，文件大小不能超过300kb'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 保存文件
        user = self.get_object()
        ser = self.get_serializer(user, data={'avatar': avatar}, partial=True)
        ser.is_valid(raise_exception=True)
        ser.save()
        return Response({'url': ser.data['avatar']})

    def bind_mobile(self, request, *args, **kwargs):
        """绑定手机号"""
        code = request.data.get('code')
        codeID = request.data.get('codeID')
        mobile = request.data.get('mobile')
        result = self.verif_code(code, codeID, mobile)
        if result:
            return Response(result, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 校验手机号
        if User.objects.filter(mobile=mobile).exists():
            return Response({'error': '该手机号已被其他用户绑定'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 绑定手机号
        user = request.user
        user.mobile = mobile
        user.save()
        return Response({'message': '绑定成功'}, status=status.HTTP_200_OK)

    def unbind_mobile(self, request, *args, **kwargs):
        """解绑手机"""
        code = request.data.get('code')
        codeID = request.data.get('codeID')
        mobile = request.data.get('mobile')
        # 参数校验和验证码
        result = self.verif_code(code, codeID, mobile)
        if result:
            return Response(result, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 解绑手机 验证用户已绑定手机号
        user = request.user
        if user.mobile == mobile:
            user.mobile = ''
            user.save()
            return Response({'message': '解绑成功'}, status=status.HTTP_200_OK)
        else:
            return Response({'error': '当前用户绑定的不是该号码'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)

    def modify_name(self, request, *args, **kwargs):
        """更改用户昵称"""
        last_name = request.data.get('last_name')
        if not last_name:
            return Response({'error': '用户名昵称不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        user = self.get_object()
        user.last_name = last_name
        user.save()
        return Response({'message': '更改昵称成功'}, status=status.HTTP_200_OK)

    def modify_email(self, request, *args, **kwargs):
        """更改邮箱"""
        email = request.data.get('email')
        if not email:
            return Response({'error': '邮箱不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not re.match(r'^[a-z0-9][\w./-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return Response({'error': '邮箱格式不正确'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 邮箱有没有被绑定
        if User.objects.filter(email=email).exists():
            return Response({'error': '该邮箱已被其他用户绑定'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        user = self.get_object()
        # 是否和原一样
        if user.email == email:
            return Response({'error': '修改的邮箱不能和原邮箱一致'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        user.email = email
        user.save()
        return Response({'message': '更改邮箱成功'}, status=status.HTTP_200_OK)

    def modify_password(self, request, *args, **kwargs):
        """修改密码"""
        user = self.get_object()
        code = request.data.get('code')
        codeID = request.data.get('codeID')
        mobile = request.data.get('mobile')
        password = request.data.get('password')
        password_confirmation = request.data.get('password_confirmation')
        result = self.verif_code(code, codeID, mobile)
        if result:
            return Response(result, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if user.mobile != mobile:
            return Response({'error': '手机号不是绑定的手机号'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not password:
            return Response({'error': '密码不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if not password_confirmation:
            return Response({'error': '重写密码不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if password != password_confirmation:
            return Response({'error': '两次密码不一致'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 修改密码
        user.set_password(password)
        user.save()
        return Response({'message': '修改密码成功'})

    @staticmethod
    def verif_code(code, codeID, mobile):
        """验证码校验的通用逻辑"""
        if not code:
            return {'error': '验证码不能为空'}
        if not codeID:
            return {'error': '验证码ID不能为空'}
        if not mobile:
            return {'error': '手机号不能为空'}
        # 校验验证码
        res = VerifCode.objects.filter(id=codeID, code=code, mobile=mobile)
        if res.exists():
            # 校验验证码是否过期，三分钟内
            c_obj = VerifCode.objects.get(id=codeID, code=code, mobile=mobile)
            c_time = c_obj.create_time.timestamp()
            # 当前时间
            e_time = time.time()
            # 删除验证码，避免出现有效期内，重复使用同一个验证码
            c_obj.delete()
            if c_time + 180 < e_time:
                return {'error': '验证码已过期，请重新获取'}
        else:
            return {'error': '验证失败，请重新获取'}


class FileView(APIView):
    permission_classes = [AllowAny]
    authentication_classes = []

    def get(self, request, name):
        path = MEDIA_ROOT / name
        if os.path.isfile(path):
            return FileResponse(open(path, 'rb'))
        return Response({'error': '文件不存在'}, status=status.HTTP_404_NOT_FOUND)


class AddrView(GenericViewSet,
               mixins.ListModelMixin,
               mixins.CreateModelMixin,
               mixins.DestroyModelMixin,
               mixins.UpdateModelMixin):
    """地址管理视图"""
    # permission_classes = [AllowAny]
    # authentication_classes = []

    queryset = Addr.objects.all()
    serializer_class = AddrSerializer
    permission_classes = [IsAuthenticated, AddrPermission]
    filterset_fields = ('user',)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        queryset = queryset.filter(user=request.user)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def set_default_addr(self, request, *args, **kwargs):
        """设置默认收货地址"""
        obj = self.get_object()
        obj.is_default = True
        obj.save()
        # 将用户的其他收货地址设置为非默认
        queryset = self.get_queryset().filter(user=request.user)
        for item in queryset:
            if item != obj:
                item.is_default = False
                item.save()
        return Response({"message": '设置成功'}, status=status.HTTP_200_OK)


class SMSView(APIView):
    """短信验证码"""
    # permission_classes = [AllowAny]
    # authentication_classes = []
    throttle_classes = (AnonRateThrottle,)

    def post(self, request, *args, **kwargs):
        mobile = request.data.get('phone')
        # 验证手机号码
        res = re.match(r'^1[3456789]\d{9}$', mobile)
        if not res:
            return Response({'error': '无效的手机号码'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        # 随机生成短信验证码
        code = self.get_random_code()
        # 发送短信验证码
        result = AliyunSMS().send(mobile=mobile, code=code)
        if result['code'] == 'OK':
            # 将短信验证码传入数据库
            obj = VerifCode.objects.create(mobile=mobile, code=code)
            result['codeID'] = obj.id
            return Response(result, status=status.HTTP_200_OK)
        else:
            return Response(result, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def get_random_code(self):
        """随机生成一个六位数验证码"""
        # code = ''.join([random.choice(range(10)) for i in range(6)])
        code = ''
        for i in range(6):
            n = random.choice(range(10))
            code += str(n)
        return code

from django.http import FileResponse
from django.shortcuts import render
import os
from rest_framework import status, mixins
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import AllowAny
from rest_framework.viewsets import GenericViewSet
from rest_framework.permissions import IsAuthenticated

from ShoppingPlatform.settings import MEDIA_ROOT
from users.models import User, Addr
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
    # queryset = User.objects.all()
    # serializer_class = UserSerializer
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

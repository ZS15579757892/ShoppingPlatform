from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import AllowAny

from users.models import User

import re


# Create your views here.
class RegisterView(APIView):
    """注册"""
    permission_classes = [AllowAny]
    authentication_classes = []

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

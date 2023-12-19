"""
自定义用户登录的认证类，实现多字段登录
"""
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q
from rest_framework import serializers

from users.models import User


class MyBackend(ModelBackend):
    """自定义登录认证类"""

    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            user = User.objects.get(Q(username=username) | Q(mobile=username) | Q(email=username))
        except:
            raise serializers.ValidationError({'error': '未找到该用户'})
        if user.check_password(password):
            return user
        else:
            raise serializers.ValidationError({'error': '密码错误'})

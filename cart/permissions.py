from rest_framework import permissions


class CartPermission(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        # 判断操作的用户对象和登录的用户对象是否是同一个用户
        # 判断是否是超级管理员
        if request.user.is_superuser:
            return True

        return obj.user == request.user

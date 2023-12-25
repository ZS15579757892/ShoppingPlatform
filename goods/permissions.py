from rest_framework import permissions


class CollectPermission(permissions.BasePermission):

    def has_object_permission(self, request, view, obj):
        # 判断是否是超级管理员
        if request.user.is_superuser:
            return True

        return obj.user == request.user

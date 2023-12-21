from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenVerifyView
from django.urls import path

from users import views

urlpatterns = [
    path('login/', views.LoginView.as_view()),
    path('register/', views.RegisterView.as_view()),
    # 刷新token
    path('token/refresh/', TokenRefreshView.as_view()),
    # 校验token
    path('token/verify/', TokenVerifyView.as_view()),
    # 获取单个用户信息
    path('users/<int:pk>/', views.UserView.as_view({'get': 'retrieve'})),
    # 上传用户头像
    path('<int:pk>/avatar/upload', views.UserView.as_view({
        'post': 'upload_avatar'
    })),
    # 添加、获取地址列表
    path('address/', views.AddrView.as_view({
        'post': 'create',
        'get': 'list'
    })),
    # 修改、删除收货地址列表
    path('address/<int:pk>/', views.AddrView.as_view({
        'delete': 'destroy',
        'put': 'update'
    })),
]

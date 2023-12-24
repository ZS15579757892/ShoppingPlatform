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
    # 设置默认收货地址
    path('address/<int:pk>/default', views.AddrView.as_view({
        'put': 'set_default_addr'
    })),
    # 发送短信验证码
    path('sendsms/', views.SMSView.as_view()),
    # 绑定手机号
    path('<int:pk>/mobile/bind', views.UserView.as_view({
        'put': 'bind_mobile'
    })),
    # 解绑手机
    path('<int:pk>/mobile/unbind', views.UserView.as_view({
        'put': 'unbind_mobile'
    })),
    # 更改用户昵称
    path('<int:pk>/name/', views.UserView.as_view({
        'put': 'modify_name'
    })),
    # 修改邮箱
    path('<int:pk>/email/', views.UserView.as_view({
        'put': 'modify_email'
    })),
    # 修改密码
    path('<int:pk>/password', views.UserView.as_view({
        'put': 'modify_password'
    })),
]

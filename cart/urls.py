from django.urls import path
from . import views

urlpatterns = [
    path('goods/', views.CartView.as_view({
        'get': 'list',
        'post': 'create'
    })),
    # 修改状态
    path('goods/<int:pk>/checked/', views.CartView.as_view({
        'put': 'modify_goods_status',
    })),
    # 修改数量
    path('goods/<int:pk>/number/', views.CartView.as_view({
        'put': 'modify_goods_number'
    })),


]

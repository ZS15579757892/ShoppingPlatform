from django.shortcuts import render
from rest_framework import mixins, status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import ReadOnlyModelViewSet, GenericViewSet

from goods.models import GoodsGroup, GoodsBanner, Goods, Collect, Detail
from goods.permissions import CollectPermission
from goods.serializers import GoodsSerializer, GoodsGroupSerializer, GoodsBannerSerializer, CollectSerializer, \
    DetailSerializer


# Create your views here.

class IndexView(APIView):
    """商城首页接口"""
    permission_classes = [AllowAny]
    authentication_classes = []

    def get(self, request):
        # 获取商品所有分类信息
        group = GoodsGroup.objects.filter(status=True)
        group_ser = GoodsGroupSerializer(group, many=True, context={'request': request})
        # 获取商品的海报图
        banner = GoodsBanner.objects.filter(status=True)
        banner_ser = GoodsBannerSerializer(banner, many=True, context={'request': request})
        # 获取所有的推荐商品
        goods = Goods.objects.filter(recommend=True)
        goods_ser = GoodsSerializer(goods, many=True, context={'request': request})
        result = dict(
            group=group_ser.data,
            banner=banner_ser.data,
            goods=goods_ser.data
        )
        return Response(result)


class GoodsView(ReadOnlyModelViewSet):
    """商品视图集"""
    # permission_classes = [AllowAny]
    authentication_classes = []
    queryset = Goods.objects.filter(is_on=True)
    serializer_class = GoodsSerializer
    # 筛选
    filter_fields = ('group', 'recommend')
    # 排序
    ordering_fields = ('price', 'sales', 'create_time')

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        # 获取商品详情
        detail = Detail.objects.get(goods=instance)
        ser = DetailSerializer(detail)
        result = serializer.data
        result['detail'] = ser.data
        return Response(result)


class CollectView(mixins.CreateModelMixin,
                  mixins.ListModelMixin,
                  mixins.DestroyModelMixin,
                  GenericViewSet):
    """
    post:收藏商品、
    delete:取消收藏、
    list:收藏列表
    """
    queryset = Collect.objects.all()
    serializer_class = CollectSerializer
    # 设置登录过的用户才能访问
    permission_classes = [IsAuthenticated, CollectPermission]

    def create(self, request, *args, **kwargs):
        """post:收藏商品、"""
        user = request.user
        params_user_id = request.data.get('user')
        if user.id != params_user_id:
            return Response({'error': '没有操作其他用户的权限'})
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        """获取用户的收藏列表"""
        queryset = self.filter_queryset(self.get_queryset())
        queryset = queryset.filter(user=request.user)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class GoodsGroupView(mixins.ListModelMixin,
                     GenericViewSet):
    queryset = GoodsGroup.objects.filter(status=True)
    serializer_class = GoodsSerializer

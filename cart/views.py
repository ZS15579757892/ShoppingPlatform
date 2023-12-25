from django.shortcuts import render
from rest_framework import mixins, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.viewsets import GenericViewSet, ModelViewSet

from cart.models import Cart
from cart.permissions import CartPermission
from cart.serializers import CartSerializer, CartInfoSerializer


# Create your views here.
class CartView(GenericViewSet,
               mixins.CreateModelMixin,
               mixins.UpdateModelMixin,
               mixins.DestroyModelMixin,
               mixins.ListModelMixin,
               ):
    """添加商品"""
    queryset = Cart.objects.all()
    serializer_class = CartSerializer
    permission_classes = [IsAuthenticated, CartPermission]

    def get_serializer_class(self):
        """实现读写"""
        if self.action == 'list':
            return CartInfoSerializer
        else:
            return CartSerializer

    def create(self, request, *args, **kwargs):
        # 获取用户信息
        user = request.user
        request.data['user'] = user.id
        goods = request.data.get('goods')
        # 校验参数
        # 购物车是否有该商品，有修改数量，没有则添加
        if Cart.objects.filter(goods=goods, user=user).exists():
            cart_goods = Cart.objects.get(goods=goods, user=user)
            cart_goods.number += 1
            cart_goods.save()
            ser = self.get_serializer(cart_goods)
            return Response(ser.data, status=status.HTTP_201_CREATED)
        else:
            request.data['user'] = user.id
            return super().create(request, *args, **kwargs)

    def list(self, request, *args, **kwargs):
        user = request.user
        queryset = self.filter_queryset(self.get_queryset())
        queryset = queryset.filter(user=user)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def modify_goods_status(self, request, *args, **kwargs):
        """修改商品的状态"""
        obj = self.get_object()
        obj.is_checked = not obj.is_checked
        obj.save()
        return Response({'message': '修改成功'}, status=status.HTTP_200_OK)

    def modify_goods_number(self, request, *args, **kwargs):
        obj = self.get_object()
        number = request.data.get('number')
        if not number and isinstance(number, int):
            raise Response({'error': '参数只能是int类型，并且不能为空'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)
        if number <= 0:
            obj.delete()
            return Response({'message': '修改成功，该商品数量为零，已从购物车移除'}, status=status.HTTP_200_OK)
        elif number > obj.goods.stock:
            return Response({'message': '数量不能超过库存'}, status=status.HTTP_422_UNPROCESSABLE_ENTITY)

        else:
            obj.number = number
            obj.save()
            return Response({'message': '修改成功'}, status=status.HTTP_200_OK)
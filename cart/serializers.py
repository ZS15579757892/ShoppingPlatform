from rest_framework import serializers

from cart.models import Cart
from goods.serializers import GoodsSerializer


class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = '__all__'


class CartInfoSerializer(serializers.ModelSerializer):
    # 用于获取数据的时候加上goods的详细信息
    goods = GoodsSerializer()

    class Meta:
        model = Cart
        fields = '__all__'

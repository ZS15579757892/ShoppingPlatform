from django.db import models

from common.db import BaseModel


# Create your models here.

class Cart(BaseModel):
    """购物车"""
    user = models.ForeignKey('users.User', verbose_name='用户ID', on_delete=models.CASCADE)
    goods = models.ForeignKey('goods.Goods', verbose_name='商品ID', on_delete=models.CASCADE)
    number = models.IntegerField(verbose_name='商品数量', default=1, blank=True)
    is_checked = models.BooleanField(verbose_name='是否选中', default=1, blank=True)

    class Meta:
        db_table = 'cart'
        verbose_name = '购物车'
        verbose_name_plural = verbose_name

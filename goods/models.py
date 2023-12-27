from ckeditor.fields import RichTextField
from django.db import models
from common.db import BaseModel


# Create your models here.

class GoodsGroup(models.Model):
    """商品类"""
    name = models.CharField(verbose_name='名称', max_length=20)
    image = models.ImageField(verbose_name='图片', null=True, blank=True)
    status = models.BooleanField(verbose_name='是否启用', default=False)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'goods_group'
        verbose_name = '商品分类表'


class Goods(BaseModel):
    """商品"""
    group = models.ForeignKey('GoodsGroup', verbose_name='分类', on_delete=models.CASCADE)
    title = models.CharField(verbose_name='标题', max_length=200, default='')
    desc = models.CharField(verbose_name='商品描述', max_length=200)
    price = models.DecimalField(verbose_name='商品价格', max_digits=10, decimal_places=2)
    cover = models.ImageField(verbose_name='封面图链接', blank=True, null=True)
    stock = models.IntegerField(verbose_name='库存', default=1, blank=True)
    sales = models.IntegerField(verbose_name='销量', default=1, blank=True)
    is_on = models.BooleanField(verbose_name='是否上架', default=False, blank=True)
    recommend = models.BooleanField(verbose_name='是否推荐', default=False, blank=True)

    class Meta:
        db_table = 'goods'
        verbose_name = '商品表'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


class Detail(BaseModel):
    """商品详情"""
    goods = models.ForeignKey('Goods', verbose_name='商品', on_delete=models.CASCADE)
    producer = models.CharField(verbose_name='厂商', max_length=200)
    norms = models.CharField(verbose_name='规格', max_length=200)
    detail = RichTextField(verbose_name='商品详情', blank=True)

    class Meta:
        db_table = 'detail'
        verbose_name = '商品详情'
        verbose_name_plural = verbose_name


class GoodsBanner(BaseModel):
    """商品轮播图"""
    title = models.CharField(verbose_name='轮播图名称', max_length=200, default='')
    image = models.ImageField(verbose_name='轮播图链接', blank=True, null=True)
    status = models.BooleanField(verbose_name='是否启用', default=False)
    seq = models.IntegerField(verbose_name='顺序', default=1, blank=True)

    class Meta:
        db_table = 'banner'
        verbose_name = '首页商品轮播图'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


class Collect(models.Model):
    """收藏商品"""
    user = models.ForeignKey('users.User', help_text='用户ID', verbose_name='用户ID', blank=True, on_delete=models.CASCADE)
    goods = models.ForeignKey('Goods', verbose_name='商品ID', blank=True, on_delete=models.CASCADE)

    class Meta:
        db_table = 'collect'
        verbose_name = '收藏商品'
        verbose_name_plural = verbose_name



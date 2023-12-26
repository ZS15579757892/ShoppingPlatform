from django.db import models
from django.contrib.auth.models import AbstractUser
from common.db import BaseModel


# Create your models here.
class User(AbstractUser, BaseModel):
    """用户模型"""
    mobile = models.CharField(verbose_name='手机号', default='', max_length=11)
    avatar = models.ImageField(verbose_name='用户头像', blank=True, null=True)

    class Meta:
        db_table = 'users'
        verbose_name = '用户表'


class Addr(models.Model):
    """收货地址表"""
    user = models.ForeignKey('User', verbose_name='所属用户', on_delete=models.CASCADE)
    phone = models.CharField(verbose_name='手机号', max_length=11)
    name = models.CharField(verbose_name='联系人', max_length=20)
    province = models.CharField(verbose_name='省份', max_length=20)
    city = models.CharField(verbose_name='城市', max_length=20)
    county = models.CharField(verbose_name='区县', max_length=20)
    address = models.CharField(verbose_name='详细地址', max_length=200)
    is_default = models.BooleanField(verbose_name='是否为默认地址', default=False)

    class Meta:
        db_table = 'addr'
        verbose_name = '收货地址表'


class Area(models.Model):
    """省市县区域表"""
    pid = models.IntegerField(verbose_name='上级id', default=True)
    name = models.CharField(verbose_name='地区名', max_length=20)
    level = models.CharField(verbose_name='区域等级', max_length=20, null=True)

    class Meta:
        db_table = 'area'
        verbose_name = '省市县区域表'


class VerifCode(models.Model):
    """手机验证码"""
    mobile = models.CharField(verbose_name="手机号", max_length=11)
    code = models.CharField(verbose_name='验证码', max_length=6)
    create_time = models.DateTimeField(verbose_name='生成时间', auto_now_add=True)

    class Meta:
        db_table = 'VerifCode'
        verbose_name = '手机验证码表'

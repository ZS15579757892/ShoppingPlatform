from django.db import models


class BaseModel(models.Model):
    """抽象的模型类 定义一些公共字段"""
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='更新时间')
    is_delete = models.BooleanField(default=False, verbose_name='删除标记')

    class Meta:
        # 抽象模型
        abstract = True
        verbose_name_plural = '公共字段模型'
        db_table = 'BaseTable'

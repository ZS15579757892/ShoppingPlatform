from django.contrib import admin

from users.models import User, Addr, Area, VerifCode


# Register your models here.
@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['mobile', 'avatar']


@admin.register(Addr)
class AddrAdmin(admin.ModelAdmin):
    list_display = ['user', 'phone', 'name', 'province', 'is_default', 'address']


@admin.register(Area)
class AreaAdmin(admin.ModelAdmin):
    list_display = ['pid', 'name', 'level']


@admin.register(VerifCode)
class VerifCodeAdmin(admin.ModelAdmin):
    list_display = ['mobile', 'code', 'create_time']

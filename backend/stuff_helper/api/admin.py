from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from core.models import User, Services, Benefit, Request, Category


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    list_display = (
        'id', 'username', 'email', 'department',
        'employee_id', 'is_staff', 'is_active'
    )
    list_filter = ('is_staff', 'is_active', 'department')
    search_fields = ('username', 'email', 'department', 'employee_id')
    ordering = ('id',)

    fieldsets = (
        ('Информация о сотруднике', {
            'fields': ('employee_id', 'department'),
        }),
        ('Аутентификация', {
            'fields': ('username', 'password'),
        }),
        ('Личные данные', {
            'fields': ('first_name', 'last_name', 'email'),
        }),
        ('Права доступа', {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        ('Важные даты', {
            'fields': ('last_login', 'date_joined'),
        }),
    )

    add_fieldsets = (
        ('Создание пользователя', {
            'classes': ('wide',),
            'fields': (
                'username', 'password1', 'password2',
                'employee_id', 'department',
                'is_staff', 'is_active'
            ),
        }),
    )


@admin.register(Services)
class ServicesAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'category', 'is_active')
    list_filter = ('category', 'is_active')
    search_fields = ('title', 'description')
    actions = ['make_active', 'make_inactive']

    def make_active(self, request, queryset):
        queryset.update(is_active=True)
    make_active.short_description = "Сделать выбранные услуги активными"

    def make_inactive(self, request, queryset):
        queryset.update(is_active=False)
    make_inactive.short_description = "Сделать выбранные услуги неактивными"


@admin.register(Benefit)
class BenefitAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'category', 'is_active')
    list_filter = ('category', 'is_active')
    search_fields = ('title', 'description')
    actions = ['make_active', 'make_inactive']

    def make_active(self, request, queryset):
        queryset.update(is_active=True)
    make_active.short_description = "Сделать выбранные льготы активными"

    def make_inactive(self, request, queryset):
        queryset.update(is_active=False)
    make_inactive.short_description = "Сделать выбранные льготы неактивными"


@admin.register(Request)
class RequestAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'service', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'user', 'created_at')
    search_fields = ('user__username', 'service__title')
    list_editable = ('status',)
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at')

    fieldsets = (
        ('Основная информация', {
            'fields': ('user', 'service', 'status'),
        }),
        ('Системная информация', {
            'fields': ('created_at', 'updated_at'),
        }),
    )


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name',)
    list_filter = ('name',)
    search_fields = ('id', 'name',)
    ordering = ('-id',)

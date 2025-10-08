from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from core.models import User, Services, Benefit, Request, Category


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    list_display = (
        'id', 'username', 'email', 'department',
        'employee_id', 'is_staff', 'is_active')
    list_filter = ('is_staff', 'is_active', 'department', 'employee_id')
    search_fields = ('username', 'email', 'department', 'employee_id')
    ordering = ('id',)
    fieldsets = (
        ('Employee Info', {
            'fields': ('employee_id', 'department'),
        }),
        ('Authentication', {
            'fields': ('username', 'password'),
        }),
        ('Personal info', {
            'fields': ('first_name', 'last_name', 'email'),
        }),
        ('Permissions', {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        ('Important dates', {
            'fields': ('last_login', 'date_joined'),
        }),
    )

    # Also adjust add form
    add_fieldsets = (
        (None, {
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
    make_active.short_description = "Mark selected Services as active"

    def make_inactive(self, request, queryset):
        queryset.update(is_active=False)
    make_inactive.short_description = "Mark selected services as inactive"


@admin.register(Benefit)
class BenefitAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'category', 'is_active')
    list_filter = ('category', 'is_active')
    search_fields = ('title', 'description')
    actions = ['make_active', 'make_inactive']

    def make_active(self, request, queryset):
        queryset.update(is_active=True)
    make_active.short_description = "Mark selected benefits as active"

    def make_inactive(self, request, queryset):
        queryset.update(is_active=False)
    make_inactive.short_description = "Mark selected benefits as inactive"


@admin.register(Request)
class RequestAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'service', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'user', 'created_at')
    search_fields = ('user__username', 'service__title')
    list_editable = ('status',)
    ordering = ('-created_at',)


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'name',)
    list_filter = ('id', 'name',)
    search_fields = ('id', 'name',)
    ordering = ('-id',)

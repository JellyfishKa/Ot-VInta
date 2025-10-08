from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    employee_id = models.IntegerField(
        unique=True,
        verbose_name="Табельный номер",
        blank=True,
        null=True,
    )
    department = models.CharField(
        max_length=100,
        verbose_name="Отдел"
    )

    class Meta:
        verbose_name = "Сотрудник"
        verbose_name_plural = "Сотрудники"
        ordering = ["employee_id"]

    def __str__(self):
        return f"{self.username} ({self.employee_id})"


class Category(models.Model):
    id = models.IntegerField(
        primary_key=True,
        unique=True,
        verbose_name="ID категории",
    )
    name = models.CharField(
        max_length=50,
        verbose_name="Название категории",
    )

    class Meta:
        verbose_name = "Категория"
        verbose_name_plural = "Категории"
        ordering = ["id"]

    def __str__(self):
        return self.name


class Services(models.Model):
    id = models.IntegerField(
        primary_key=True,
        unique=True,
        verbose_name="ID услуги",
    )
    title = models.CharField(
        max_length=300,
        blank=False,
        null=False,
        verbose_name="Название"
    )
    description = models.TextField(
        blank=True,
        verbose_name="Описание"
    )
    category = models.ForeignKey(
        to=Category,
        verbose_name="Категория",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name="Активна"
    )

    class Meta:
        verbose_name = "Услуга"
        verbose_name_plural = "Услуги"
        ordering = ["title"]

    def __str__(self):
        return self.title


class Benefit(models.Model):
    title = models.CharField(
        max_length=255,
        verbose_name="Название льготы"
    )
    description = models.TextField(
        blank=True,
        verbose_name="Описание"
    )
    category = models.ForeignKey(
        to=Category,
        verbose_name="Категория",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name="Активна"
    )

    class Meta:
        verbose_name = "Льгота"
        verbose_name_plural = "Льготы"
        ordering = ["title"]

    def __str__(self):
        return self.title


class Request(models.Model):
    class Status(models.TextChoices):
        PENDING = "pending", "В ожидании"
        APPROVED = "approved", "Одобрена"
        REJECTED = "rejected", "Отклонена"
        COMPLETED = "completed", "Выполнена"

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name="Пользователь"
    )
    service = models.ForeignKey(
        Services,
        on_delete=models.CASCADE,
        verbose_name="Услуга"
    )
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.PENDING,
        verbose_name="Статус"
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name="Дата создания"
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name="Дата обновления"
    )

    class Meta:
        verbose_name = "Заявка"
        verbose_name_plural = "Заявки"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Заявка {self.id} — {self.user} ({self.get_status_display()})"

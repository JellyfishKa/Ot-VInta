from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    employee_id = models.IntegerField(
        unique=True,
        verbose_name="Employee ID",
        blank=True,
        null=True,
    )
    department = models.CharField(
        max_length=100,
        verbose_name="Department"
    )

    class Meta:
        verbose_name = "Employee"
        verbose_name_plural = "Employees"
        ordering = ["employee_id"]

    def __str__(self):
        return f"{self.username} ({self.employee_id})"


class Category(models.Model):
    id = models.IntegerField(
        primary_key=True,
        unique=True,
        verbose_name="Category ID",
    )
    name = models.CharField(
        max_length=50,
        verbose_name="Category Name",
    )

    class Meta:
        verbose_name = "Category"
        verbose_name_plural = "Categories"
        ordering = ["id"]

    def __str__(self):
        return self.name


class Services(models.Model):
    id = models.IntegerField(
        primary_key=True,
        unique=True,
        verbose_name="Service's ID",
    )
    title = models.CharField(
        max_length=300,
        blank=False,
        null=False,
        verbose_name="Title"
    )
    description = models.TextField(
        blank=True,
        verbose_name="Description"
    )
    category = models.ForeignKey(
        to=Category,
        verbose_name="Category",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name="Is Active"
    )

    class Meta:
        verbose_name = "Service"
        verbose_name_plural = "Services"
        ordering = ["title"]

    def __str__(self):
        return self.title


class Benefit(models.Model):
    title = models.CharField(
        max_length=255,
        verbose_name="Title"
    )
    description = models.TextField(
        blank=True,
        verbose_name="Description"
    )
    category = models.ForeignKey(
        to=Category,
        verbose_name="Category",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name="Is Active"
    )

    class Meta:
        verbose_name = "Benefit"
        verbose_name_plural = "Benefits"
        ordering = ["title"]

    def __str__(self):
        return self.title


class Request(models.Model):
    class Status(models.TextChoices):
        PENDING = "pending", "Pending"
        APPROVED = "approved", "Approved"
        REJECTED = "rejected", "Rejected"
        COMPLETED = "completed", "Completed"

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name="User"
    )
    service = models.ForeignKey(
        Services,
        on_delete=models.CASCADE,
        verbose_name="Service"
    )
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.PENDING,
        verbose_name="Status"
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name="Created At"
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name="Updated At"
    )

    class Meta:
        verbose_name = "Request"
        verbose_name_plural = "Requests"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Request {self.id} — {self.user} ({self.get_status_display()})"
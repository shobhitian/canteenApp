from django_use_email_as_username.models import BaseUser, BaseUserManager
from django.db import models

from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
class CustomUserManager(BaseUserManager):
    pass  


class User(BaseUser):
    STATUS_CHOICES = (
        ('1', 'pending'),
        ('2', 'approved'),
        ('3', 'suspended'),
    )
    DEVICE_CHOICES = (
        ('1', 'android'),
        ('2', 'ios'),
        
    )
    current_year = timezone.now().year
    year_of_joining = models.PositiveIntegerField(
        validators=[
            MinValueValidator(2000, message='Year of joining must be a valid year.'),
            MaxValueValidator(current_year, message='Year of joining cannot be in the future.')
        ]
    )
    emp_code = models.CharField(max_length=20, unique=True)
    name = models.CharField(max_length=255)
    status = models.CharField(max_length=225, choices=STATUS_CHOICES, default='1')
    device_type = models.CharField(max_length=225, choices=DEVICE_CHOICES, default='null')
    device_token = models.CharField(max_length=255,default='null',null=True)
    otp = models.CharField(max_length=255, blank=True, null=True)
    objects = CustomUserManager()




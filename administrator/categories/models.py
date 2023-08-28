from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User
# Create your models here.
class Category(models.Model):
    STATUS_CHOICES = (
        (1, 'pending'),
        (2, 'active'),
        (3, 'inactive'),
    )
    name = models.CharField(max_length=255)
    image = models.ImageField(upload_to='category_images/')
    status = models.BooleanField(max_length=225, choices=STATUS_CHOICES, default=True)
    ref_user =  models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        db_table = "categories"
    
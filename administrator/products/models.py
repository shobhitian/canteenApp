from django.db import models
from django.contrib.auth.models import User
from administrator.categories.models import Category

# Create your models here.
class Product(models.Model):
    
   
    Availabilities = (
        (1, 'Daily'),
        (2, 'Specific_days'),
    )
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    description = models.TextField()
    image = models.ImageField(upload_to='product_images/')
    price = models.IntegerField(null=False)
    status = models.BooleanField(default=True)
    stock = models.BooleanField(default=True)
    availability = models.IntegerField(choices=Availabilities, default=1)
    ref_user =  models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        db_table = "products"

     
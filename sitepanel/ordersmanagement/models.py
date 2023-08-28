from django.db import models
from django.contrib.auth.models import User
from administrator.categories.models import Category
from administrator.products.models import Product
from django.core.validators import MinValueValidator

class CafeTimes(models.Model):
    startTime = models.TimeField(default=None)
    endTime = models.TimeField(default=None)
    is_open = models.BooleanField(default=True)

    class Meta:
        db_table = "cafe_times"
        
class Wallet(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    balance = models.PositiveIntegerField()
    status = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "wallet"

class Order(models.Model):
    STATUS_CHOICES = (
        (1, 'ordered'),
        (2, 'preparing'),
        (3, 'prepared'),
        (4, 'delivered'),
        (5, 'cancelled'),
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total_amount = models.IntegerField(null=False)
    description = models.CharField(max_length=255,null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    status = models.IntegerField(choices=STATUS_CHOICES, default=1)

    class Meta:
        db_table = "orders"
        
class OrderItems(models.Model):
   
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    price = models.IntegerField(null=False)

    class Meta:
        db_table = "order_items"


# add to cart
class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    price = models.IntegerField(null=False)
    quantity = models.PositiveIntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = "cart"    


class Collection(models.Model):
   
    amount_credited = models.FloatField(null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)
    total_amount = models.FloatField(null=True, blank=True)
    spare_amount = models.FloatField(null=True, blank=True)

    class Meta:
        db_table = "collection"       

class Transaction(models.Model):
    TYPE_CHOICES = (
        (0, 'credited'),
        (1, 'debited'),
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='transactions')
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='created_transactions')
    order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)
    amount = models.DecimalField(max_digits=8, decimal_places=2, default=0, validators=[MinValueValidator(0)])
    type = models.BooleanField(choices=TYPE_CHOICES,default=0)
    collection = models.ForeignKey(Collection, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "transaction"    




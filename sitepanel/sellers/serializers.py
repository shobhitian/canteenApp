from rest_framework import serializers
from administrator.products.models import Product, Order
from .models import CafeTimes, Cart, Order, OrderItems, Transaction, Wallet
from django.contrib.auth.models import User
from sitepanel.ordersmanagement.serializers import CafeTimesSerializer, OrderItemSerializer, ProductSerializer, OrderSerializer
from rest_framework import serializers
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'emp_code','year_of_joining']

# serializers.py


class OrderItemsSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItems
        fields = '__all__'

class SellerOrderSerializer(serializers.ModelSerializer):
    order_items = OrderItemsSerializer(many=True)  # Include the nested serializer

    class Meta:
        model = Order
        fields = '__all__'

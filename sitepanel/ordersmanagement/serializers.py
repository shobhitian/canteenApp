from rest_framework import serializers
from administrator.products.models import Product
from .models import CafeTimes, Cart, Order, OrderItems, Transaction, Wallet
from django.contrib.auth.models import User
from sitepanel.models import UserProfile

from django.conf import settings

class ProductSerializer(serializers.ModelSerializer):
    
    image = serializers.SerializerMethodField()
    class Meta:
        model = Product
        fields = '__all__'

    def get_image(self, instance):
        # base_url = "http://192.180.2.128:5151"  # Your base URL
        if instance.image:
            image_url = instance.image.url
            return f"{settings.BASE_URL}{image_url}"
        return None
class CafeTimesSerializer(serializers.ModelSerializer):
    class Meta:
        model = CafeTimes
        fields = '__all__'
class CartSerializer(serializers.ModelSerializer):
    product = ProductSerializer()
    class Meta:
        model = Cart
        fields = '__all__'
        
class OrderItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer()
    class Meta:
        model = OrderItems
        fields = '__all__'        
        
class OrderSerializer(serializers.ModelSerializer):
    items = serializers.SerializerMethodField()
    class Meta:
        model = Order
        fields = '__all__'  
    def get_items(self,obj):
        try:
            return OrderItemSerializer(OrderItems.objects.filter(order=obj),many=True).data
        except:pass



class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['year_of_joining', 'emp_code']

class UserSerializer(serializers.ModelSerializer):
    user_profile = UserProfileSerializer()  # Include the UserProfile details

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'user_profile']

class SellerOrderSerializer(serializers.ModelSerializer):
    items = serializers.SerializerMethodField()
    user = UserSerializer()
    class Meta:
        model = Order
        # fields = '__all__' 
        fields = [ 'user', 'id', 'total_amount', 'description', 'created_at', 'updated_at', 'status','items'] 
    def get_items(self,obj):
        try:
            return OrderItemSerializer(OrderItems.objects.filter(order=obj),many=True).data
        except:pass
        
        
class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = '__all__' 
        
class WalletSerializer(serializers.ModelSerializer):
    class Meta:
        model = Wallet
        fields = '__all__' 
        
    # def get_items(self,obj):
    #     try:
    #         return OrderItemSerializer(OrderItems.objects.filter(order=obj),many=True).data
    #     except:pass
            


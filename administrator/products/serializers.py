from rest_framework import serializers
from administrator.products.models import Product

class ProductSerializer(serializers.ModelSerializer):
    
    image = serializers.SerializerMethodField()
    class Meta:
        model = Product
        fields = '__all__'

    def get_image(self, instance):
        base_url = "http://192.180.2.128:5151"  # Your base URL
        if instance.image:
            image_url = instance.image.url
            return f"{base_url}{image_url}"
        return None



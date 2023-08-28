from rest_framework import serializers
from administrator.categories.models import Category
from django.conf import settings

class CategorySerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = '__all__'

    def get_image(self, instance):
        
        if instance.image:
            image_url = instance.image.url
            return f"{settings.BASE_URL}{image_url}"
        return None
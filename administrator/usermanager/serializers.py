from rest_framework import serializers
from django.contrib.auth.models import User

from sitepanel.models import UserProfile

class UserSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    user_type = serializers.SerializerMethodField()
    class Meta:
        model = User
        fields = ('id','name','email','user_type','is_active')
    def get_name(self, obj):
        return obj.first_name
    def get_user_type(self, obj):
        try:
            data = UserProfile.objects.get(ref_user=obj.id)
            response = data.user_type
        except UserProfile.DoesNotExist:
            response = None
        return response

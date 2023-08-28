from configurations.settings import ALLOWED_IMAGE_EXTENSIONS
from commonConf.baseViewSet import  appBaseViewset
from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.response import Response
from sitepanel.serializers import UserSerializers
from sitepanel.models import UserProfile
from commonConf.response import *

# Create your views here.
class ManageProfile(appBaseViewset):
    queryset = User.objects
    subQueryset = UserProfile.objects
    serializer_class = UserSerializers
    http_method_names = ['get','put','post']
    
    
    def list(self, request, *args, **kwargs):
        try:
            data = self.queryset.get(id=request.user.id)
            serializedData = self.serializer_class(data).data
            return Response({
                        "data" :serializedData,
                        "message": "User fetch successfully",
                        "status": False,
                        "response": "fail", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message": PROFILEDOESNOTEXIST,
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
    
    def create(self, request, *args, **kwargs):
        try:
            requestedData = request.data
            user = self.queryset.get(id=request.user.id)
            if 'first_name' in requestedData:
                 user.first_name = requestedData['first_name']
            if 'last_name' in requestedData:
                user.last_name = requestedData['last_name']
            user.save()
            userProfile = self.subQueryset.get(ref_user=user)

            # Check if emp_code already exists
            emp_code = requestedData.get('emp_code', None)
            if emp_code is not None and self.subQueryset.filter(emp_code=emp_code).exclude(ref_user=user).exists():
                return Response({
                    "message": "Employee code already exists.",
                    "status": False,
                    "response": "fail"
                }, status=status.HTTP_400_BAD_REQUEST)
            # Update profile fields
            if 'profilephoto' in request.FILES:
                profilephoto = request.FILES['profilephoto']

                # Check if the uploaded file is a valid image
                image_extension = profilephoto.name.split('.')[-1].lower()
                if image_extension not in ALLOWED_IMAGE_EXTENSIONS:
                    return Response({
                        "message": f"Invalid image format. Supported formats: {', '.join(ALLOWED_IMAGE_EXTENSIONS)}.",
                        "status": False,
                        "response": "fail"
                    }, status=status.HTTP_400_BAD_REQUEST)

                userProfile.photo = profilephoto
            userProfile.phone_number = requestedData.get('number', None)
            userProfile.age = requestedData.get('age', None)
            userProfile.gender = requestedData.get('gender', None)
            if 'year_of_joining' in requestedData:
                userProfile.year_of_joining = requestedData['year_of_joining']
            # Update year_of_joining
            userProfile.emp_code = requestedData.get('emp_code', None)  # Update emp_code
            userProfile.web_token = requestedData.get('web_token', None)  
            userProfile.fcm_token = requestedData.get('fcm_token', None)  
            userProfile.save()
            serializedData = self.serializer_class(user).data
            return Response({
                        "data" :serializedData,
                        "message": "User updated successfully",
                        "status": True,
                        "response": "success", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message": PROFILEDOESNOTEXIST,
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
    
   
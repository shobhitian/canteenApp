# from commonConf.response import response_func
from django.http import HttpResponse
from rest_framework import status
from rest_framework.response import Response
from django.utils import timezone
from django.db import transaction
from django.contrib.auth.models import User,Group
from rest_framework.authtoken.models import Token
from django.contrib.auth import logout
from django.utils.crypto import get_random_string
from commonConf.authentication import token_expire_handler
from commonConf.baseViewSet import aBaseViewset, nBaseViewset
from sitepanel.authentications.login.serializers import UserLoginSerializer
from sitepanel.models import UserProfile, UserSocial
from commonConf.response import *

def home(request):
    data = "<h1>Welcome to ChicMic Canteen</h1>"
    return HttpResponse(data)

class AuthLoginViewset(nBaseViewset):
    queryset = User.objects.all()
    serializer_class = UserLoginSerializer
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        try:
            fcm_token = request.data.get('fcm_token')
            device_type = request.data.get('device_type')
            email = request.data.get('email')
            password = request.data.get('password')
            
            try:
                user = User.objects.get(email=email)
            except User.DoesNotExist:
                return Response({
                    "message": USERNOTEXIST,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)
            
            if not user.is_active:
                return Response({
                    "message": BLOCKEDYADMIN,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)
            
            if user.is_staff:
                return Response({
                    "message":ALREADYEXIST,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            if user.check_password(password):
                if Token.objects.filter(user_id=user.id).exists():
                    Token.objects.get(user_id=user.id).delete()

                token, created = Token.objects.get_or_create(user=user)
                is_expired, token = token_expire_handler(token)

                user.last_login = timezone.now()
                user.save()

                userprofile = UserProfile.objects.get(ref_user=user)
                userprofile.device_type = device_type
                if device_type != 3 :
                    userprofile.fcm_token = fcm_token
                userprofile.save()

                return Response({
                    "message": SUCCESSLOGIN,
                    "status": True,
                    "response": "success",
                    "token": token.key,
                    "data": {
                        "user_type": userprofile.user_type,
                        'username': user.username,
                        'user_id': user.id,
                        'photo': userprofile.photo.url,
                        'email': user.email,
                        "first_name": user.first_name,
                        "last_name": user.last_name,
                        "emp_code": userprofile.emp_code,
                        "year_of_joining": userprofile.year_of_joining
                    }
                }, status=status.HTTP_201_CREATED)
            else:
                return Response({
                    "message": INVALIDCREDENTIALS,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

                    
class AuthLogoutViewset(aBaseViewset):
    queryset = User.objects.filter()
    serializer_class = UserLoginSerializer
    http_method_names = ['post']    
    
    def create(self, request, *args, **kwargs):
        try:
            user = request.user
            
            logout(request)
            userprofile=UserProfile.objects.get(ref_user=user)
            if userprofile.device_type != '3':
                userprofile.fcm_token = None  # Set fcm_token to None
            else:
                userprofile.web_token = None # Set web_token to None
                
            userprofile.save()            
            return Response({
                "message":SUCCESSLOGOUT,
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        
        except UserProfile.DoesNotExist:
            return Response({
                    "message": USERNOTEXIST,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)
        
        except Exception as error:
                return Response({
                    "message": str(error),
                    "status": False,
                    "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)


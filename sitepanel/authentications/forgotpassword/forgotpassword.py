from base64 import urlsafe_b64encode
import random
import threading

from django.forms import ValidationError
from rest_framework import status
from rest_framework.response import Response
from django.db import transaction, IntegrityError
from django.contrib.auth.models import User, Group
from django.utils.encoding import force_bytes
from django.contrib.auth.tokens import default_token_generator  
from django.utils.http import (
    url_has_allowed_host_and_scheme, urlsafe_base64_decode,
)
from commonConf.baseViewSet import nBaseViewset
from commonConf.passwordValidator import password_check
from commonConf.send_email import send_forgot_password_mail
from sitepanel.authentications.forgotpassword.serializers import ChangePasswordSerializer, ForgotPasswordSerializer
from sitepanel.models import UserProfile
from commonConf.response import *
from django.utils.http import urlsafe_base64_decode
from django.contrib.auth.models import User
from sitepanel.models import UserProfile

class ForgotPasswordMail(nBaseViewset):
    queryset = User.objects.filter()
    serializer_class = ForgotPasswordSerializer
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        
        try:
            email = request.data['email']
            user = User.objects.get(email=email)
                # user=User.objects.get(email=email)
            if UserProfile.objects.get(ref_user=user).verified ==  False:
                return Response(
                    {"message": NOTVERIFIED,
                            "status": False,
                            "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
            
            with transaction.atomic():
                userprofile=UserProfile.objects.get(ref_user=user)
                userprofile.otp=random.randint(100000, 999999)
                userprofile.save()
            context1 = {
                    "subject": "Forgot Password mail",
                    "username": user.username,
                    "code": userprofile.otp,
                    "email": user.email,
                    "user": user,
                    'protocol': 'http',
                }
            t = threading.Thread(target=send_forgot_password_mail, args=[
                email, context1])
            t.setDaemon(True)
            t.start()
            return Response( {"message": MAILSEND,
                        "status": True,
                        "response": "success", }, status=status.HTTP_201_CREATED)

        except User.DoesNotExist:
            return Response({
                "message": NOTREGISTERED,
                "status": False,
                "response": "fail", }, status=status.HTTP_404_NOT_FOUND)
        except Exception as error:
                    return Response({
                        "message": str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
class ChangePassword(nBaseViewset):
    queryset = User.objects
    serializer_class = ChangePasswordSerializer
    http_method_names = ['get']
    def get_user(self, uidb64):
        try:
            # urlsafe_base64_decode() decodes to bytestring
            uid = urlsafe_base64_decode(uidb64).decode()
            user = User._default_manager.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist, ValidationError):
            user = None
        return user
    def list(self, request, *args, **kwargs):
        try:
         
            uid = self.kwargs['uid']
            token=self.kwargs['token']
            compect = {
                "uid":uid,
                "token":token
            }
            return Response({
                            'data': compect,
                            "message":"", 
                            "status": True,
                            "response": "success", }, status=status.HTTP_200_OK)
          
        except Exception as error:
                    return Response({
                        "message": str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)




class ConfirmPassword(nBaseViewset):
    queryset = User.objects
    serializer_class = ChangePasswordSerializer
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        try:
            otp = request.data['otp']
            email = request.data['email']

            user = self.queryset.filter(email=email).first()
            if user is None:
                return Response({
                    "message": "User doesn't exist.",
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            userprofile = UserProfile.objects.get(ref_user=user)
            if userprofile.otp != int(otp):
                return Response({
                    "message": "Invalid OTP.",
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            # If OTP is valid, remove the OTP to prevent its reuse
            userprofile.otp = None
            userprofile.save()

            # Return a success response indicating OTP verification
            return Response({
                "message": "OTP verified successfully.",
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

class UpdatePassword(nBaseViewset):
    queryset = User.objects
    serializer_class = ChangePasswordSerializer
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        try:
            password = request.data['password']
            email = request.data['email']

            password_validate = password_check(password)
            if not password_validate['status']:
                return Response({
                    "message": password_validate['message'],
                    "status": password_validate['status'],
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            user = self.queryset.filter(email=email).first()
            if user is None:
                return Response({
                    "message": USERNOTEXIST,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            # Update the user's password
            user.set_password(password)
            user.save()

            return Response({
                "message": "Password changed successfully.",
                "status": True,
                "response": "success",
            }, status=status.HTTP_201_CREATED)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

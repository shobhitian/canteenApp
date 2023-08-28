from base64 import urlsafe_b64encode
import threading
from django.forms import ValidationError
from django.shortcuts import render
from rest_framework import  status
from rest_framework.response import Response
from django.db import transaction
from django.contrib.auth.models import Group,User
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes
from django.utils.http import (
    url_has_allowed_host_and_scheme, urlsafe_base64_decode,
)
from django.utils.crypto import get_random_string

from commonConf.baseViewSet import nBaseViewset, vBaseViewset
from commonConf.passwordValidator import password_check
from commonConf.send_email import send_welcome_mail
from sitepanel.authentications.signup.serializers import UserSerializers
from sitepanel.models import UserProfile
import re
from commonConf.response import *
from sitepanel.ordersmanagement.models import Wallet



from django.db import IntegrityError

class AuthSignupViewset(nBaseViewset):
    queryset = User.objects
    serializer_class = UserSerializers
    profileQuerySet = UserProfile.objects
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        data = request.data
        try:
            with transaction.atomic():
                if User.objects.filter(email=data["email"]).exists():
                    user = self.queryset.get(email=data["email"])
                    if self.profileQuerySet.filter(ref_user=user).exists():
                        return Response({
                            "message": USEDEMAIL,
                            "status": False,
                            "response": "fail"
                        }, status=status.HTTP_400_BAD_REQUEST)
                
                if str(data["email"]).lstrip() == "":
                    return Response({
                        "message": INVALIDEMAIL,
                        "status": False,
                        "response": "fail"
                    }, status=status.HTTP_400_BAD_REQUEST)
                else:
                    regex = r'\b^(([^<>()\\.,;:\s@"]+(\.[^<>()\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$\b'
                    if not re.fullmatch(regex, data["email"]):
                        return Response({
                            "message": INVALIDEMAIL,
                            "status": False,
                            "response": "fail"
                        }, status=status.HTTP_400_BAD_REQUEST)
             
                password_validate = password_check(data["password"])
                if not password_validate['status']: 
                    return Response({
                        "message": password_validate['message'],
                        "status": password_validate['status'],
                        "response": "fail"
                    }, status=status.HTTP_400_BAD_REQUEST)
                
                try:
                    if self.queryset.filter(username=data["username"]).exists():
                        return Response({
                            "message": USEDUSERNAME,
                            "status": False,
                            "response": "fail"
                        }, status=status.HTTP_400_BAD_REQUEST)
                except:
                    pass
                
                try:
                    emp_code = data['emp_code']
                    username = emp_code.split("/")[-1]
                except:
                    username = get_random_string(15)
                
                userData = self.queryset.create(
                    username=username,
                    email=data["email"],
                    first_name=data["first_name"],
                    last_name=data["last_name"],
                    is_active=False,
                )
                userData.set_password(data["password"])
                userData.save()
                userprofile = UserProfile.objects.create(ref_user=userData, user_type=3, verified=0, year_of_joining=data.get('year_of_joining'), emp_code=data['emp_code'])
                
                if userprofile.user_type:
                    wallet = Wallet.objects.create(user=userData, balance=0)
                
                context = {
                    "subject": "welcome mail",
                    "username": userData.username,
                    "email": userData.email,
                    "uid": urlsafe_b64encode(force_bytes(userData.pk)),
                    "user": userData,
                    'token': default_token_generator.make_token(userData),
                    'protocol': 'http',
                    "url": request._current_scheme_host + '/api/app/auth/verifyuser/' + urlsafe_b64encode(force_bytes(userData.pk)).decode('utf-8') + '/' + default_token_generator.make_token(userData) + "/",
                }
                t = threading.Thread(target=send_welcome_mail, args=[
                    userData.email, context])
                t.setDaemon(True)
                t.start()
                
                group = Group.objects.get(name='user')
                group.user_set.add(userData)
                
                return Response({
                    "email": request.data['email'],
                    "message": "Your registration has been successfully completed. You have just been sent an email containing a verification link.",
                    "status": True,
                    "response": "success"
                }, status=status.HTTP_200_OK)
        except IntegrityError as integrity_error:
            return Response({
                "message": "This employee code is already taken. Please choose a different employee code.",
                "status": False,
                "response": "fail"
            }, status=status.HTTP_400_BAD_REQUEST)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"
            }, status=status.HTTP_400_BAD_REQUEST)


class UserVerification(vBaseViewset):
    queryset = User.objects.all()
    serializer_class = UserSerializers
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
            try:
                user = self.get_user(uid)
                if user == None:
                    return render(request,'expired-link.html')
                userprofile=UserProfile.objects.get(ref_user=user)
                if userprofile.verified == True:
                    return render(request,'expired-link.html')
                if(default_token_generator.check_token(user,token)):
                    userprofile.verified = True
                    userprofile.save()
                    return render(request,'verified-link.html')
                else:
                    return render(request,'expired-link.html')
            except Exception as error:
                return Response({"message":str(error), "status": False,
                                "response": "fail", }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        except Exception as error:
                return Response({"message":str(error), "status": False,
                                "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
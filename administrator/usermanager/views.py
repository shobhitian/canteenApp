from rest_framework import status
from rest_framework.response import Response
from django.contrib.auth.models import User
from administrator.usermanager.serializers import UserSerializer
from commonConf.baseViewSet import aBaseViewset
from django.utils.crypto import get_random_string
from sitepanel.models import UserProfile
from base64 import urlsafe_b64encode
from django.contrib.auth.models import Group,User
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes
import threading
from commonConf.send_email import send_welcome_mail_with_password



class UsersView(aBaseViewset):
    queryset=User.objects
    serializer_class=UserSerializer
    http_method_names=['post','get','put','delete']
    
    def create(self, request, *args, **kwargs):
        try:
            name = request.data['name']
            is_active =  request.data['status']
            email =  request.data['email']
            user_type = request.data['user_type']
            if not name or not is_active or not email or not user_type:
                return Response({"message":"name,email,status,user_type can not be empty","status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            username = get_random_string(15)
            if user_type == 1 or user_type == 2:
                is_staff = 1
            else:
                is_staff = 0
                
            userData = self.queryset.create(
                first_name=name,
                is_active =is_active,
                email=email,
                username=username,
                is_staff = is_staff,
                is_superuser = 0
            ) 
            password = get_random_string(8)
            userData.set_password(password)
            userData.save()
            userprofile=UserProfile.objects.create(ref_user=userData,verified=0)
            context1 = {
                "subject": "welcome mail",
                "username": userData.username,
                "email": userData.email,
                "uid": urlsafe_b64encode(force_bytes(userData.pk)),
                "user": userData,
                'token': default_token_generator.make_token(userData),
                'protocol': 'http',
                'password':password,
                "url": request._current_scheme_host+'/api/app/auth/verifyuser/'+urlsafe_b64encode(force_bytes(userData.pk)).decode('utf-8') +'/'+default_token_generator.make_token(userData) + "/",
            }
            t = threading.Thread(target=send_welcome_mail_with_password, args=[
                userData.email, context1])
            t.setDaemon(True)
            t.start()       
            group = Group.objects.get(
                                    name='user')
            group.user_set.add(userData)
            return Response({
                "message":"The User has been successfully added to our system.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({"message":str(error),"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)

    def list(self, request, *args, **kwargs):
        try:
            search = request.GET.get('name')
            page = request.GET.get('page')
            if not page:
                return Response({"message":"page feild is required","status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            if int(page) > 1:
                offset = (int(page) - 1) * 10
                limit = 10
            else:
                offset = 0
                limit = 10
            count = self.queryset.filter(first_name__icontains=search).exclude(is_superuser=1).count()
            dataset = self.queryset.filter(first_name__icontains=search).exclude(is_superuser=1).order_by('-id')[offset:offset+limit]
               
            serialized = self.serializer_class(dataset,many=True).data
            return Response({
                'data':serialized,
                'count':count,
                "message":"The users has been successfully fetched.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"},status=status.HTTP_400_BAD_REQUEST)


    def retrieve(self, request, *args, **kwargs):
        try:
            if not self.queryset.filter(id= int(self.kwargs['pk'])).exists():
                return Response({
                    "message": "user not found in our system",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            dataset = self.queryset.get(id= int(self.kwargs['pk']))
            serialized = self.serializer_class(dataset).data

            return Response({
                'data':serialized,
                "message":"The user has been successfully fetched.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)

    def update(self, request, *args, **kwargs):
        try:
            dataset = self.queryset.get(id= int(self.kwargs['pk']))
            dataset.first_name=request.data['name']
            dataset.is_active =request.data['status']
            dataset.save()
            return Response({
                "message":"The user has been successfully updated.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
    
    def destroy(self, request, *args, **kwargs):
        try:
            obj_id=self.kwargs['pk']    
            self.queryset.get(id=obj_id).delete()
            return Response({
                    "message": "The user has been deleted.",
                    "status": True,
                    "response": "success"}, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                        "message": str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
class UserStatusView(aBaseViewset):
    queryset=User.objects
    serializer_class=UserSerializer
    http_method_names=['post']

    def create(self, request, *args, **kwargs):
        try:
            data = request.data
            if not self.queryset.filter(id= data['id']).exists():
                return Response({
                    "message": "user not found in our system",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            dataset = self.queryset.get(id=data['id'])
            dataset.is_active =data['status']
            dataset.save()
            return Response({
                "message":"The user status has been successfully updated.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
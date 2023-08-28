from rest_framework import status
from rest_framework.response import Response
from administrator.categories.models import Category
from administrator.categories.serializers import CategorySerializer
from commonConf.baseViewSet import aBaseViewset


class CategoryView(aBaseViewset):
    queryset=Category.objects
    serializer_class=CategorySerializer
    http_method_names=['post','get','put','delete']
    
    def create(self, request, *args, **kwargs):
        try:
            data = request.data
        
            createObject = self.queryset.create(
                name=data['name'],
                image= request.FILES['image'],
                ref_user = request.user,
                status =data['status']
            )
            return Response({
                "message":"The category has been successfully added to our system.",
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
            count = self.queryset.filter(name__icontains=search).count()
            dataset = self.queryset.filter(name__icontains=search).order_by('-id')[offset:offset+limit]
               
            serialized = self.serializer_class(dataset,many=True).data
            return Response({
                'data':serialized,
                'count':count,
                "message":"The categories has been successfully fetched.",
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
                    "message": "product not found in our system",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            dataset = self.queryset.get(id= int(self.kwargs['pk']))
            serialized = self.serializer_class(dataset).data

            return Response({
                'data':serialized,
                "message":"The category has been successfully fetched.",
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
            name = request.data['name']
            dstatus = request.data['status']
            if not name or not dstatus:
                return Response({
                    "message": "name and status can not be empty",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            
            dataset.name = name
            dataset.status = dstatus
            try:
                if request.FILES['image']:
                    dataset.image= request.FILES['image']
            except:
                pass
            dataset.save()
            # serialized = StagesupdateSerializer(Symptom).data
            return Response({
                # 'data':serialized,
                "message":"The category has been successfully updated.",
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
                    "message": "The category has been deleted.",
                    "status": True,
                    "response": "success"}, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                        "message": str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)

class CategoryStatusView(aBaseViewset):
    queryset=Category.objects
    serializer_class=CategorySerializer
    http_method_names=['post']

    def create(self, request, *args, **kwargs):
        try:
            data = request.data
            if not self.queryset.filter(id= data['id']).exists():
                return Response({
                    "message": "category not found in our system",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            dataset = self.queryset.get(id=data['id'])
            dataset.status =data['status']
            dataset.save()
            return Response({
                "message":"The category status has been successfully updated.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
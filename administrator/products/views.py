from rest_framework import status
from rest_framework.response import Response
from administrator.products.models import Product
from administrator.products.serializers import ProductSerializer
from commonConf.baseViewSet import aBaseViewset


class ProductView(aBaseViewset):
    queryset=Product.objects
    serializer_class=ProductSerializer
    http_method_names=['post','get','put','delete']
    
    def create(self, request, *args, **kwargs):
        try:
            data = request.data
        
            createObject = self.queryset.create(
                name=data['name'],
                category_id=int(data['category_id']),
                description=data['description'],
                image= request.FILES['image'],
                price= data['price'],
                stock=data['stock'],
                availability=data['availability'],
                ref_user = request.user,
                status =data['status']
            ) 
            return Response({
                "message":"The Product has been successfully added to our system.",
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
                "message":"The products has been successfully fetched.",
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
                "message":"The Product has been successfully fetched.",
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
            data = request.data
            name = request.data['name']
            dstatus = request.data['status']
            price = request.data['price']
            availability = request.data['availability']
            stock = request.data['stock'] if request.data['stock'] else 0

            if not name or not dstatus or not price:
                return Response({
                    "message": "name and status can not be empty",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            
            dataset.name=name
            dataset.description=data['description']
            dataset.price= price
            dataset.stock=stock
            dataset.availability=availability
            dataset.ref_user = request.user
            dataset.status =data['status']
            try:
                if request.FILES['image']:
                    dataset.image= request.FILES['image']
            except:
                pass
            dataset.save()
            
            return Response({
                "message":"The Product has been successfully updated.",
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
                    "message": "The Product has been deleted.",
                    "status": True,
                    "response": "success"}, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                        "message": str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
        
class ProductStatusView(aBaseViewset):
    queryset=Product.objects
    serializer_class=ProductSerializer
    http_method_names=['post']

    def create(self, request, *args, **kwargs):
        try:
            data = request.data
            if not self.queryset.filter(id= data['id']).exists():
                return Response({
                    "message": "product not found in our system",
                    "status": False,
                    "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
            dataset = self.queryset.get(id=data['id'])
            dataset.status =data['status']
            dataset.save()
            return Response({
                "message":"The product status has been successfully updated.",
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail"}, status=status.HTTP_400_BAD_REQUEST)
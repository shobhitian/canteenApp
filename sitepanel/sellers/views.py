from commonConf.baseViewSet import aBaseViewset
from rest_framework.response import Response
from sitepanel.ordersmanagement.serializers import CafeTimesSerializer, ProductSerializer
from rest_framework import status
from administrator.products.models import Product
from sitepanel.ordersmanagement.models import CafeTimes, Order,Transaction, Wallet
from sitepanel.ordersmanagement.serializers import SellerOrderSerializer
from django.contrib.auth.hashers import make_password
from rest_framework.views import APIView
from sitepanel.notifications import send_notification, send_web_notification
from sitepanel.models import UserProfile
from django.db.models import Prefetch
from commonConf.response import *
#switch for cafe
class CafeTimesView(aBaseViewset):
    queryset = CafeTimes.objects
    serializer_class = CafeTimesSerializer
    http_method_names = ['get', 'post']
    def list(self, request, *args, **kwargs):
        try:
            serializer = self.serializer_class(self.queryset.filter().first()).data
            return Response({
                "data": serializer,
                "message": CAFETIME,
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
        
    def create(self, request, *args, **kwargs):
        try:
            cafeStatus =  request.data['status']
            data = self.queryset.filter().first()
            data.is_open = int(cafeStatus)
            data.save()
            return Response({
                "message": STATUSUPDATED,
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
#Toggle the product stock       
class ProductStockView(aBaseViewset):
    queryset = Product.objects
    serializer_class = ProductSerializer
    http_method_names = ['put']
    def update(self, request, *args, **kwargs):
        try:
            product_id = kwargs.get('pk')
            try:
                product = Product.objects.get(id=product_id,status=True)
            except Product.DoesNotExist:
                return Response({
                    "message": NOTFOUND,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_404_NOT_FOUND)

            # Toggle the stock value between 0 and 1
            if product.stock == 0:
                product.stock = 1
            elif product.stock == 1:
                product.stock = 0
            else:
                return Response({'message': INVALID}, status=status.HTTP_400_BAD_REQUEST)
            # Save the updated Product object
            product.save()

            serializer = self.serializer_class(product).data
            return Response({
                "data": serializer,
                "message": STOCKPRODUCT,
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
#get the orders and change the status
class sellerOrderView(aBaseViewset):
    queryset = Order.objects.all()
    serializer_class = SellerOrderSerializer
    http_method_names = ['get', 'put']

    def list(self, request, *args, **kwargs):
        try:
            type = request.GET.get('status')
            page = request.GET.get('page')
            search = request.GET.get('name')
            user = request.user
            user_profile = UserProfile.objects.get(ref_user_id=user)
         
            if not page or not type:
                return Response({
                    "message": PAGEANDSTATUS,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            type = int(type)
            if int(page) > 1:
                offset = (int(page) - 1) * 10
                limit = 10
            else:
                offset = 0
                limit = 10

            if type == 0:  
                order_ids = self.queryset.filter(orderitems__product__name__icontains=search).values_list('id', flat=True).distinct()
            else:
  
                order_ids = self.queryset.filter(orderitems__product__name__icontains=search, status=type).values_list('id', flat=True).distinct()

            dataset = self.queryset.filter(id__in=order_ids).order_by('-id')
            dataset = dataset.prefetch_related(Prefetch('orderitems_set__product', to_attr='order_items'))

            # Apply offset and limit after fetching the unique orders
            count = dataset.count()
            dataset = dataset[offset:offset+limit]

            serializer = self.serializer_class(dataset, many=True).data
            
            return Response({
                "count": count,
                "data": serializer,
                "message": ORDERFETCH,
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)
        
        except Exception as error:

            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

    def update(self, request, *args, **kwargs):
        try:
            admin = UserProfile.objects.filter(user_type=2).values_list('ref_user_id', flat=True).first()
            # Get the order based on the provided order_id (pk in URL)
            order_id = kwargs.get('pk')
            try:
                order = Order.objects.get(pk=order_id)
            except Order.DoesNotExist:
                return Response({
                    "message": NOTFOUND,
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_404_NOT_FOUND)

            # Get the new status value from the request data
            new_status = request.data.get('status')
            # Get the user_id from the order
            user_id = order.user_id
            user_profile = UserProfile.objects.get(ref_user_id=user_id)
            # Check if the new status is valid
            valid_statuses = ['2', '3', '4', '5']
            if new_status not in valid_statuses:
                return Response({
                    "message": "Invalid status",
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)
            
            # Check if the order status is changing to "5" (cancelled)
            if order.status != '5' and new_status == '5':
                # Create a new Transaction object for order cancellation
                transaction = Transaction.objects.create(
                collection_id=None,    
                amount=order.total_amount,
                user_id=user_id,
                order=order,
                type=0,  # Set as a string
                created_by_id=admin
                )
                # Update the user's wallet balance
                try:
                    wallet = Wallet.objects.get(user_id=user_id)
                    wallet.balance += order.total_amount
                    wallet.save()
                except Wallet.DoesNotExist:
                    # Handle if the user's wallet does not exist
                    pass
            # Update the order status
            order.status = new_status
            order.save()
            # Prepare the response data
            response_data = {
                "message": ORDER,
                "status": True,
                "response": "success",
            }
            notification_messages = {
                '2': "Your order is being prepared.",
                '3': "Your order is prepared and will be delivered soon.",
                '4': "Your order has been delivered successfully.",
                '5': "Your order has been cancelled from the seller.",
            }
            # Send notification to the user phone
            if user_profile.fcm_token:
                try:
                    fcm_token = user_profile.fcm_token
                    message_title = "Order Status Update"
                    message_body = notification_messages[new_status].format(order_id=order.pk)
                    send_notification(fcm_token=fcm_token, title=message_title, body=message_body)
                except Exception as fcm_error:
                    print("FCM Notification Error:", str(fcm_error))
            # Send notification to web app
            if user_profile.web_token:
                try:
                    registration_id = user_profile.web_token
                    message_title = "Order Status Update"
                    message_body = notification_messages[new_status].format(order_id=order.pk)
                    send_web_notification(message_title, message_body, registration_id)
                except Exception as web_notification_error:
                    print("Web Notification Error:", str(web_notification_error))                
            return Response(response_data, status=status.HTTP_200_OK)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)   

#password Api for admin panel 
class Password(APIView):
    http_method_names = ['post','get']
    def post(self, request, *args, **kwargs):
        try:
            data = request.data.get('inputPassword')
            if data is not None:
                encrypted_string = make_password(data)
                return Response({"encrypted_string": encrypted_string}, status=status.HTTP_200_OK)
            return Response({"message": "Invalid request or missing data"}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

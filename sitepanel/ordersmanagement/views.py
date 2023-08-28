
from administrator.categories.models import Category
from administrator.categories.serializers import CategorySerializer
from administrator.products.models import Product
from sitepanel.models import UserProfile
from sitepanel.notifications import send_notification, send_web_notification
from .serializers import CafeTimesSerializer, ProductSerializer, CartSerializer, OrderSerializer, TransactionSerializer, WalletSerializer
from commonConf.baseViewSet import aBaseViewset
from .models import CafeTimes, Order, OrderItems, Wallet,Transaction
from rest_framework import status
from rest_framework.response import Response
from .models import Cart
from .serializers import CartSerializer
from rest_framework.pagination import PageNumberPagination
from django.shortcuts import get_object_or_404
from django.contrib.auth.models import User
from commonConf.response import *
# from rest_framework.pagination import PageNumberPagination

class GetCategories(aBaseViewset):
    queryset = Category.objects
    serializer_class = CategorySerializer
    http_method_names = ['get']

    def list(self, request,*args, **kwargs):
        try:
            Category = self.queryset.filter( status=True)
            serializer = self.serializer_class(Category, many=True).data
            return Response({
                            "data" :serializer,
                            "message": CATFETCH,
                            "status": True,
                            "response": "success", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message":  str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
        
class ProductsByCategoryView(aBaseViewset):
    queryset = Product.objects.order_by('id')
    serializer_class = ProductSerializer
    querysetT = CafeTimes.objects.all()
    serializer_Time = CafeTimesSerializer
    http_method_names = ['get']
    pagination_class = PageNumberPagination  # Add the pagination class here

    def list(self, request, *args, **kwargs):
        try:
            cat_id = request.GET.get('category_id', None)
            if not cat_id:
                return Response({
                    "message": "category_id is required",
                    "status": False,
                    "response": "fail",
                }, status=status.HTTP_400_BAD_REQUEST)

            # Get the search query from the request
            search_query = request.GET.get('search', '')

            # Filtering products by category id
            products = self.queryset.filter(category_id=cat_id, status=True)

            # Apply search filter if search_query is provided
            if search_query:
                # Perform case-insensitive search on the name field
                products = products.filter(name__icontains=search_query)

            # Apply sorting based on stock
            products = products.order_by('-stock')

            # Apply pagination to the queryset
            paginated_products = self.paginate_queryset(products)
            if paginated_products is not None:
                serializer = self.serializer_class(paginated_products, many=True).data

                # Get the user's cart (assuming you have an authenticated user)
                user_cart = Cart.objects.filter(user=request.user)
                cart_data = {}

                # Extract product quantities from the cart and store in a dictionary
                for item in user_cart:
                    cart_data[item.product_id] = item.quantity

                time = self.querysetT.all()
                timing = self.serializer_Time(time, many=True).data
                is_open = next((t["is_open"] for t in timing if "is_open" in t), None)

                # Include product quantities in the serialized data
                for product_data in serializer:
                    product_id = product_data['id']
                    product_data['quantity_in_cart'] = cart_data.get(product_id, 0)

                return self.get_paginated_response({
                    "data": serializer,
                    "message": PRODUCTSFETCH,
                    "cafe_switch": is_open,
                    "status": True,
                    "response": "success",
                })

            return Response({
                "data": [],
                "message": NOPRODUCT,
                "cafe_switch": None,  # If no products found, set is_open to None or any default value you prefer.
                "status": True,
                "response": "success",
            }, status=status.HTTP_200_OK)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)




class AddToCartView(aBaseViewset):
    queryset = Cart.objects
    serializer_class = CartSerializer
    querysetT = CafeTimes.objects.all()
    serializer_Time = CafeTimesSerializer
    http_method_names = ['post','get', 'delete','put']

    def create(self, request, *args, **kwargs):
        try:
            product = request.data['product_id']
            quantity = request.data['quantity']
            
            product = Product.objects.get(pk=product)  # Assuming you have a Product model
            price = product.price
            if  self.queryset.filter(product_id=product,user=request.user).exists():
                return Response({"message":"already added in cart","status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
        
            createObject = self.queryset.create(
                product_id=product.id,
                quantity=quantity,
                price=price,
                user=request.user
            ) 
            return Response({
                "message":ADDTOCART,
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({"message":str(error),"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
        
    def update(self, request, *args, **kwargs):
        try:
            quantity = request.data['quantity']
            if not self.queryset.filter(product_id=int(self.kwargs['pk']),user=request.user).exists():
                return Response({"message":NOTAVAILABLEITEM,"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            if quantity > 0:
                data = self.queryset.get(product_id=int(self.kwargs['pk']),user=request.user)
                data.quantity=quantity
                data.save()
            else:
                self.queryset.filter(product_id=int(self.kwargs['pk']),user=request.user).delete()
            return Response({
                "message":UPDATEDCART,
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)
        except Exception as error:
            return Response({"message":str(error),"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
    
    def list(self, request, *args, **kwargs):
        try:
            # Get all cart items for the user
            search = request.GET.get('name')
            page = request.GET.get('page')
            if not page:
                return Response({"message":PAGE,"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            
            limit = 10
            offset = 0
            if int(page) > 1:
                offset = (int(page) - 1) * 10
                
            count = self.queryset.filter(product__name__icontains=search,user=request.user).count()
            dataset = self.queryset.filter(product__name__icontains=search, user=request.user).order_by('-id')[offset:offset+limit]
            datasetA = self.queryset.filter(product__name__icontains=search, user=request.user)
            amount = 0
            for i in datasetA:
                amount += (i.product.price)*i.quantity
            serialized = self.serializer_class(dataset,many=True).data

            querysetT = CafeTimes.objects.all()
            is_open = querysetT.first().is_open if querysetT.exists() else None

            return Response({
                'final_amount':amount,
                'data':serialized,
                'count':count,
                "cafe_switch": is_open,
                "message":PRODUCTSFETCH,
                "status":True,
                "response":"success"
            },status=status.HTTP_200_OK)

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "cafe_switch": None,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
        
    def destroy(self, request, *args, **kwargs):
        try:
            instance = self.get_object()
            self.perform_destroy(instance)
            return Response({"message": CARTDELETE}, status=status.HTTP_204_NO_CONTENT)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)    

class ClearCart(aBaseViewset):
    queryset = Cart.objects
    serializer_class = CartSerializer
    http_method_names = ['post']
    def create(self, request, *args, **kwargs):
        try:
            user_carts = self.queryset.filter(user=request.user)
            if user_carts.exists():
                user_carts.delete()
                return Response({"message": ALLCARTDELETE}, status=status.HTTP_200_OK)
            else:
                return Response({"message": CARTNOTFOUND}, status=status.HTTP_404_NOT_FOUND)
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
        
class PlaceOrderView(aBaseViewset):
    queryset = Order.objects
    querysetC = Cart.objects
    querysetW = Wallet.objects
    serializer_class = OrderSerializer
    http_method_names = ['post','put']
    # for placing a order
    def create(self, request, *args, **kwargs):
        try:
            user = request.user
            cafe_times = get_object_or_404(CafeTimes, id=1)  # Assuming you have CafeTimes with ID 1
            if not cafe_times.is_open:
                return Response({'message': 'Cafe is not open'}, status=status.HTTP_400_BAD_REQUEST)
            # Retrieve cart items for the user
            cart_items = Cart.objects.filter(user=user)
            # Validate if cart is not empty
            if not cart_items.exists():
                return Response({'message': 'Cart is empty'}, status=status.HTTP_400_BAD_REQUEST)
            # Calculate the total amount based on the cart items
            amount = 0
            for cart_item in cart_items:
                amount += cart_item.product.price * cart_item.quantity
            # Retrieve the user's wallet
            wallet = Wallet.objects.get(user=user)
            # Check if the wallet balance is sufficient
            if wallet.balance < amount:
                return Response({'message': LOWBALANCE}, status=status.HTTP_400_BAD_REQUEST)
            # Deduct the payment amount from the wallet balance
            wallet.balance -= amount
            wallet.save()

            # Create the order
            order = Order.objects.create(
                user=user,
                total_amount=amount,
                status=1
            )

            # Create order items from cart items
            for cart_item in cart_items:
                OrderItems.objects.create(
                    order=order,
                    product=cart_item.product,
                    quantity=cart_item.quantity,
                    price = cart_item.price,
                )

            #Delete cart items after order creation
            cart_items.delete()
            user_profile = UserProfile.objects.get(ref_user_id=user)
            #Create an entry in the Transaction table
            transaction = Transaction.objects.create(
                collection_id=None,
                amount=amount,
                user=user,
                order=order,
                type=1,
                created_by_id=user.id
            )
            #send notification
            seller_profile = UserProfile.objects.get(user_type=4)  # Assuming there is only one seller
            if seller_profile.fcm_token:

                fcm_token = seller_profile.fcm_token  
                notification_title = "New Order Received"
                notification_body = "New Order Received!"
                send_notification(fcm_token, notification_title, notification_body)
                
            return Response({'message': 'Order placed successfully', 'order_id': order.pk})           
        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)
   

    # for canceling the order
    def update(self, request, *args, **kwargs):
        try:
            user = request.user
            admin = UserProfile.objects.filter(user_type=2).values_list('ref_user_id', flat=True).first()
            try:
                order = Order.objects.get(pk=int(self.kwargs['pk']), user=user)
            except Order.DoesNotExist:
                return Response({'message': 'Invalid order_id'}, status=400)

            # Check if the order status is eligible for cancellation
            if order.status not in [1]:
                return Response({'message': 'Order cannot be canceled'}, status=400)

            # Get the total_amount from the order
            total_amount = order.total_amount

            # Update the order status to 5 (cancelled)
            order.status = 5
            order.save()
            
            # Create an entry in the Transaction table
            transaction = Transaction.objects.create(
                collection_id=None,
                amount=total_amount,
                user=user,
                order=order,
                type=0,
                created_by_id=admin
            )
            
            # Update the user's wallet balance
            wallet = Wallet.objects.get(user=user)
            wallet.balance += total_amount
            wallet.save()
            seller_profile = UserProfile.objects.get(user_type=4)  # Assuming there is only one seller
            # fcm_token = seller_profile.fcm_token
            if seller_profile.device_type == 1:
                fcm_token = seller_profile.fcm_token  
                notification_title = "Order Cancelled by the User"
                notification_body = f"User  Cancelled the order please do not prepare."
                send_notification(fcm_token, notification_title, notification_body)
        

            return Response({'message': 'Order status updated to cancelled','refunded_amount':total_amount, 'order_id': order.pk})

        except Exception as error:
            return Response({
                "message": str(error),
                "status": False,
                "response": "fail",
            }, status=status.HTTP_400_BAD_REQUEST)

#order history        
class GetMyOrdersView(aBaseViewset):
    queryset = Order.objects
    serializer_class = OrderSerializer
    http_method_names = ['get']

    def list(self, request,*args, **kwargs):
        try:
            type = int(request.GET.get('status',0))
            page = request.GET.get('page')
            if not page:
                return Response({"message":PAGE,"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            if int(page) > 1:
                offset = (int(page) - 1) * 10
                limit = 10
            else:
                offset = 0
                limit = 10
            if type ==  0:    
                count = self.queryset.filter(user=request.user).count()
                dataset = self.queryset.filter(user=request.user).order_by('-id')[offset:offset+limit]
            #running order for web    
            elif type ==  6:    
                status_values = [1, 2, 3]
                count = self.queryset.filter(user=request.user, status__in=status_values).count()
                dataset = self.queryset.filter(user=request.user, status__in=status_values).order_by('-id')[offset:offset+limit]
            #order history  for web    
            elif type ==  7:    
                status_values = [4,5]
                count = self.queryset.filter(user=request.user, status__in=status_values).count()
                dataset = self.queryset.filter(user=request.user, status__in=status_values).order_by('-id')[offset:offset+limit]       
            else:
                count = self.queryset.filter(user=request.user,status=type).count()
                dataset = self.queryset.filter(user=request.user,status=type).order_by('-id')[offset:offset+limit]
                
            serializer = self.serializer_class(dataset, many=True).data
            return Response({
                            "count":count,
                            "data" :serializer,
                            "message": "Orders fetch successfully",
                            "status": True,
                            "response": "success", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message":  str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
# wallet history        
class WalletHistoryView(aBaseViewset):
    queryset = Transaction.objects
    serializer_class = TransactionSerializer
    http_method_names = ['get']

    def list(self, request,*args, **kwargs):
        try:
            
            page = request.GET.get('page')
            if not page:
                return Response({"message":PAGE,"status":False,"response":"fail"},
                status=status.HTTP_400_BAD_REQUEST)
            if int(page) > 1:
                offset = (int(page) - 1) * 10
                limit = 10
            else:
                offset = 0
                limit = 10
            count = self.queryset.filter(user=request.user).count()
            dataset = self.queryset.filter(user=request.user).order_by('-id')[offset:offset+limit]
        
                
            serializer = self.serializer_class(dataset, many=True).data
            return Response({
                            "count":count,
                            "data" :serializer,
                            "message": "History fetch successfully",
                            "status": True,
                            "response": "success", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message":  str(error),
                        "status": False,
                        "response": "success", }, status=status.HTTP_400_BAD_REQUEST)
class WalletView(aBaseViewset):
    queryset = Wallet.objects
    serializer_class = WalletSerializer
    http_method_names = ['get']

    def list(self, request,*args, **kwargs):
        try:
            dataset = self.queryset.get(user=request.user)
            serializer = self.serializer_class(dataset).data
            return Response({
                            "data" :serializer,
                            "message": "Wallet fetch successfully",
                            "status": True,
                            "response": "success", }, status=status.HTTP_200_OK)
        except Exception as error:
                    return Response({
                        "message":  str(error),
                        "status": False,
                        "response": "fail", }, status=status.HTTP_400_BAD_REQUEST)
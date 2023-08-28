from rest_framework import routers
from django.urls import path
from sitepanel.authentications.forgotpassword.forgotpassword import ChangePassword, ConfirmPassword, ForgotPasswordMail, UpdatePassword
from sitepanel.authentications.login.views import AuthLoginViewset, AuthLogoutViewset
from sitepanel.authentications.resetpassword.resetpassword import ResetPassword
from sitepanel.authentications.signup.views import AuthSignupViewset, UserVerification
from sitepanel.ordersmanagement.views import AddToCartView, ClearCart, GetCategories, GetMyOrdersView, PlaceOrderView, ProductsByCategoryView, WalletHistoryView, WalletView
from sitepanel.views import ManageProfile
from sitepanel.sellers.views import CafeTimesView, ProductStockView,sellerOrderView,Password

router = routers.DefaultRouter()

router.register(r'auth/register', AuthSignupViewset)
router.register(r'auth/login', AuthLoginViewset)
router.register(r'auth/logout',AuthLogoutViewset)
router.register(r'auth/resetpassword', ResetPassword)
router.register(r'auth/forgotpassword',ForgotPasswordMail)
router.register(r'auth/ConfirmPassword',ConfirmPassword)
router.register(r'auth/UpdatePassword',UpdatePassword)
router.register(r'auth/ManageProfile',ManageProfile)

router.register(r'getProductViaCat',ProductsByCategoryView)
router.register(r'addToCart',AddToCartView)
router.register(r'placeOrder',PlaceOrderView)
router.register(r'categories',GetCategories)

router.register(r'ClearCart',ClearCart)
router.register(r'getMyOrders',GetMyOrdersView)
router.register(r'getMyWalletHistory',WalletHistoryView)
router.register(r'getMyWallet',WalletView)

router.register(r'productStock',ProductStockView)
router.register(r'sellerOrder',sellerOrderView)
router.register(r'cafeTime',CafeTimesView)

urlpatterns = [
    path('auth/verifyuser/<uid>/<token>/',UserVerification.as_view({'get':'list'}),name="userverification"),
    path('auth/changepassword/<uid>/<token>/',ChangePassword.as_view({'get':'list'}),name="changepassword"),
    path('api/encrypt/', Password.as_view(), name='encrypt_api'),
]


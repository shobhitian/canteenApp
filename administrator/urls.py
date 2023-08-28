from rest_framework import routers
from django.urls import path
from administrator.authentications.forgotpassword.forgotpassword import ChangePassword, ConfirmPassword, ForgotPasswordMail
from administrator.authentications.login.views import AuthLoginViewset, AuthLogoutViewset
from administrator.authentications.resetpassword.resetpassword import ResetPassword
from administrator.categories.views import CategoryStatusView, CategoryView
from administrator.products.views import ProductStatusView, ProductView
from administrator.usermanager.views import UserStatusView, UsersView
from administrator.views import AdminManageProfile
router = routers.DefaultRouter()

router.register(r'auth/login', AuthLoginViewset)
router.register(r'auth/logout',AuthLogoutViewset)
router.register(r'auth/resetpassword', ResetPassword)
router.register(r'auth/forgotpassword',ForgotPasswordMail)
router.register(r'auth/ConfirmPassword',ConfirmPassword)
router.register(r'auth/ManageProfile',AdminManageProfile)


router.register(r'category',CategoryView)
router.register(r'product',ProductView)
router.register(r'users',UsersView)
router.register(r'userStatus',UserStatusView)
router.register(r'productStatus',ProductStatusView)
router.register(r'categoryStatus',CategoryStatusView)



urlpatterns = [
    path('auth/changepassword/<uid>/<token>/',ChangePassword.as_view({'get':'list'}),name="changepassword"),
]


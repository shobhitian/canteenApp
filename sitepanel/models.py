from django.db import models

# Create your models here.
from django.contrib.auth.models import User
from django.forms import CharField
import uuid
from django.utils.translation import ugettext_lazy as _
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
from django.core.validators import FileExtensionValidator

from django.db import models
from django.contrib.auth.models import User
from commonConf.choices import SocialChoices, UserChoices
from django.core.exceptions import ValidationError
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

def validate_image_extension(value):
    valid_extensions = ['.jpg', '.jpeg', '.png']
    file_extension = value.name.split('.')[-1].lower()
    if file_extension not in valid_extensions:
        raise ValidationError(_("Unsupported file extension."))

class UserProfile(models.Model):
    userType = (
        (1, 'SuperAdmin'),
        (2, 'Admin'),
        (3, 'User'),
        (4, 'seller'),
    )
    DEVICE_CHOICES = (
    (1, 'Android'),
    (2, 'iOS'),
    (3, 'Web'),
    )
    ref_user = models.OneToOneField(
        User, related_name="user_profile", on_delete=models.CASCADE)
    uuid = models.UUIDField(
        primary_key=False, default=uuid.uuid4, editable=False)
    photo = models.ImageField(upload_to='users_photo/', default="user.png",
                              null=True, blank=True, verbose_name=_("photo"),validators=[validate_image_extension])
    phone_number = models.CharField(null=True, max_length=12)
    verified = models.BooleanField(default=0)
    web_token = models.TextField(null=True,blank=True) 
    fcm_token = models.TextField(null=True,blank=True)  
    user_type =models.IntegerField(choices=userType, default=3)
    emp_code =  models.CharField(unique=True,null=True, max_length=15)
    device_type = models.IntegerField(choices=DEVICE_CHOICES, default=3)
    otp = models.IntegerField( null=True, blank=True, default=None)
    current_year = timezone.now().year
    year_of_joining = models.PositiveIntegerField(
        validators=[
            MinValueValidator(2000, message='Year of joining must be a valid year.'),
            MaxValueValidator(current_year, message='Year of joining cannot be in the future.')
        ],blank=True
    )
    gender = models.CharField(max_length=128,null=True,blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = "user_profile"

class UserSocial(models.Model):
    ref_user = models.OneToOneField(
        User, related_name="user_social", on_delete=models.CASCADE)
    social_type = models.CharField(
        max_length=30,
        choices=SocialChoices.choices()
    )
    social_id = models.CharField(max_length=255, blank=True, null=True)
    twitter_username = models.CharField(max_length=255,null=True)
    instagram_username = models.CharField(max_length=255,null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "user_social"


class ForgotPassword(models.Model):
    token = models.CharField(max_length=100)
    fp_user = models.ForeignKey(User, on_delete=models.CASCADE)
    expiry_time = models.DateTimeField()
    class Meta:
        db_table = "forgot_password"



from django.contrib.sessions.models import Session

class CustomToken(models.Model):
    DEVICE_CHOICES = (
    (1, 'Android'),
    (2, 'iOS'),
    (3, 'Web'),
    )
    user = models.ForeignKey(User, related_name='custom_tokens', on_delete=models.CASCADE)
    key = models.CharField(max_length=40, unique=True)
    purpose = models.CharField(max_length=255) 
    device_type = models.IntegerField(choices=DEVICE_CHOICES, default=3)




def validate_photo(photo):
    if not photo.content_type.startswith('image/'):
        raise ValidationError('Only images can be uploaded.')


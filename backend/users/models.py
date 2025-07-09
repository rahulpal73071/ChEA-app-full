from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager, PermissionsMixin
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _


def validate_file_extension(value):
    if not value.name.endswith('.pdf'):
        raise ValidationError(_('Only PDF files are allowed.'))

class UserManager(BaseUserManager):
    def create_user(self,email,password=None,**extra_fields):
        if not email:
            raise ValueError('The Email is required')
        email = self.normalize_email(email)
        user = self.model(email=email,**extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self,email,password=None,**extra_fields):
        extra_fields.setdefault('is_staff',True)
        extra_fields.setdefault('is_superuser',True)
        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True')

        return self.create_user(email,password,**extra_fields)

class User(AbstractUser,PermissionsMixin):
    username = None
    email = models.EmailField(unique=True,max_length=255)
    name = models.CharField(max_length=50,null=True,blank=True)
    password = models.CharField(max_length=50)
    roll_no = models.CharField(max_length=50)
    mobile_number = models.CharField(max_length=10,null=True,blank=True)
    resume1 = models.FileField(upload_to='one_page_resumes/',null=True,blank=True,validators=[validate_file_extension])
    resume2 = models.FileField(upload_to='two_page_resumes/',null=True,blank=True,validators=[validate_file_extension]) 
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    
    objects = UserManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['roll_no']
    
    def __str__(self):
        return self.email



class Student(models.Model):
    roll_no = models.CharField(max_length=50)
    name = models.CharField(max_length=50)
    ldap_id = models.CharField(max_length=50)
    
    def __str__(self):
        return f"{self.name} - {self.roll_no} - {self.ldap_id}"
    
from django.urls import path
from . import views

urlpatterns = [
    path('forget-password/', views.forget_password, name='forget_password'),
    path('reset-password/', views.reset_password, name='reset_password'),
    path('data/', views.fet_user_data, name='user_data'),
    path('update_resume1/', views.update_resume1, name='update_resume1'),
    path('update_resume2/', views.update_resume2, name='update_resume2'),
]
from django.urls import path
from .views import create_blog, get_all_blogs, get_blogs_by_type

urlpatterns = [
    path('create/', create_blog),
    path('all/', get_all_blogs),
    path('<str:blog_type>/', get_blogs_by_type),  # /blogs/Internship/ or /blogs/Placement/
]

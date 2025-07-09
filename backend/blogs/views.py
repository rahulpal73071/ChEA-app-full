from rest_framework.decorators import api_view, permission_classes, parser_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework import status

from .models import Blog
from .serializers import BlogSerializer

# POST: Create a blog (requires authentication)
@api_view(['POST'])
@permission_classes([IsAuthenticated])
@parser_classes([MultiPartParser, FormParser])
def create_blog(request):
    print("== Incoming Blog Post ==")
    print("Request.FILES:", request.FILES)
    print("Request.DATA:", request.data)

    serializer = BlogSerializer(data=request.data, context={'request': request})
    if serializer.is_valid():
        serializer.save(user=request.user)
        print("Blog saved successfully!")
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    else:
        print("Errors:", serializer.errors)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# GET: Filter blogs by type (e.g., Internship / Placement)
@api_view(['GET'])
def get_blogs_by_type(request, blog_type):
    blogs = Blog.objects.filter(blog_type=blog_type).order_by('-date')
    serializer = BlogSerializer(blogs, many=True, context={'request': request})
    return Response(serializer.data, status=status.HTTP_200_OK)

# GET: Fetch all blogs
@api_view(['GET'])
def get_all_blogs(request):
    blogs = Blog.objects.all().order_by('-date')
    serializer = BlogSerializer(blogs, many=True, context={'request': request})
    return Response(serializer.data, status=status.HTTP_200_OK)

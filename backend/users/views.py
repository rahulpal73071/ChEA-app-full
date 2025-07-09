from xml.dom import ValidationErr
from rest_framework import status
from django.core.mail import send_mail
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.contrib.auth import get_user_model
from rest_framework.response import Response
from rest_framework.decorators import api_view,permission_classes
from rest_framework.permissions import IsAuthenticated
from .serializers import UserSignupSerializer, UserSerializer
from django.contrib.auth import authenticate,get_user_model
from rest_framework.authtoken.models import Token
from django.core.exceptions import ValidationError


@api_view(['POST'])
def signup(request):
    serializer = UserSignupSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        token, created = Token.objects.get_or_create(user=user)
        data = serializer.data
        data['token'] = token.key
        return Response(data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def userlogin(request):
    email = request.data.get('email')
    password = request.data.get('password')
    user = authenticate(email=email, password=password)
    if user is not None:
        token,_ = Token.objects.get_or_create(user=user)
        return Response({'token':token.key},status=status.HTTP_200_OK)
    return Response(status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def userlogout(request):
    request.user.auth_token.delete()
    return Response(status=status.HTTP_200_OK)

@api_view(['POST'])
def forget_password(request):
    email = request.data.get('email')
    User = get_user_model()
    try:
        user = User.objects.get(email=email)
        token = default_token_generator.make_token(user)
        uid = urlsafe_base64_encode(force_bytes(user.pk))
        reset_link = f"http://localhost:3000/reset-password/{uid}/{token}"
        send_mail(
            'Password Reset Request',
            f"Click on the link to reset your password: {reset_link}",
            'from CHEA COUNCIL',
            [email],
            fail_silently=False,
        )
        return Response({'message':"Password reset email sent successfully"},status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({'message':"User does not exist"},status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def reset_password(request):
    uidb64 = request.data.get('uid')
    token = request.data.get('token')
    new_password = request.data.get('new_password')
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        user = get_user_model().objects.get(pk=uid)
    except (TypeError, ValueError, OverflowError, get_user_model().DoesNotExist):
        user = None
    
    if user is not None and default_token_generator.check_token(user, token):
        user.set_password(new_password)
        user.save()
        return Response({'message':"Password reset successfully"},status=status.HTTP_200_OK)

    return Response({'message':"Invalid reset link"},status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def fet_user_data(request):
    User = get_user_model()
    try:
        user = request.user
        serializer = UserSerializer(user)
        return Response(serializer.data,status=status.HTTP_200_OK)
    except User.DoesNotExist:
        return Response({'message':"User does not exist"},status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def update_resume1(request):
    user = request.user
    resume_file = request.FILES.get('resume1')
    if not resume_file:
        return Response({'message':"Resume file is required"},status=status.HTTP_400_BAD_REQUEST)
    try:
        user.resume1 = resume_file
        user.save()
        return Response({'message':"Resume uploaded successfully"},status=status.HTTP_200_OK)
    except ValidationError as e:
        print('validation error')
        return Response({'message': str(e)},status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def update_resume2(request):
    user = request.user
    resume_file = request.FILES.get('resume2')
    if not resume_file:
        return Response({'message':"Resume file is required"},status=status.HTTP_400_BAD_REQUEST)
    try:
        user.resume2 = resume_file
        user.save()
        return Response({'message':"Resume uploaded successfully"},status=status.HTTP_200_OK)
    except ValidationError as e:
        return Response({'message': str(e)},status=status.HTTP_400_BAD_REQUEST)
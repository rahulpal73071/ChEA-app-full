from rest_framework import serializers # type: ignore
from django.contrib.auth import get_user_model
# from .models import User
from .models import Student
User = get_user_model()

class UserSignupSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'password', 'roll_no']
        extra_kwargs = {
            'password': {'write_only': True}
        }
        

    def create(self, validated_data):
        # print(validated_data)
        email = validated_data['email'].lower()
        roll_no = validated_data['roll_no'].upper()
        # print(Student.objects.get(ldap_id = email))
        try:
            student = Student.objects.get(ldap_id=email)
        except Student.DoesNotExist:
            raise serializers.ValidationError("This LDAP ID is not authorized to sign up.")
        
        if User.objects.filter(email=email).exists():
            print("User already exists")
            raise serializers.ValidationError("User already exists")
        user = User.objects.create_user(
            email=email,
            password=validated_data['password'],
            roll_no=roll_no,
            name = student.name if student else None
        )
        return user
    
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['email', 'roll_no', 'name', 'mobile_number', 'resume1', 'resume2']
        extra_kwargs = {
            'password': {'write_only': True}
        }
        
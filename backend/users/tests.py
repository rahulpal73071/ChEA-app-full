
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from users.models import Student

class UserAccountTests(TestCase):
    def setUp(self):
        self.client = APIClient()
        Student.objects.create(roll_no='23b0354', name='Test Student', ldap_id='23b0354@iitb.ac.in')
        self.user_data = {
            'email': '23b0314@iitb.ac.in',
            'password': 'testpassword123',
            'roll_no': '23b0314'
        }
        self.user = get_user_model().objects.create_user(**self.user_data)
    
    def test_signup(self):
        print(Student.objects.all())
        url = '/signup/'
        user_data = {
            'email': '23b0354@iitb.ac.in',
            'password': 'testpassword123',
            'roll_no': '23b0354'
        }
        response = self.client.post(url,user_data, format='json')
        print(response.data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
    
    def test_login(self):
        url = '/login/'
        response = self.client.post(url,{
            'email': self.user_data['email'],
            'password': self.user_data['password']
            }, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
    
    def test_logout(self):
        url = '/signup/'
        user_data = {
            'email': '23b0354@iitb.ac.in',
            'password': 'testpassword123',
            'roll_no': '23b0354'
        }
        response = self.client.post(url,user_data, format='json')
        token = response.data['token']
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + token)
        logout_url = '/logout/'
        response = self.client.post(logout_url)
        print(response)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        

class UserPasswordResetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = get_user_model().objects.create_user(
            email= 'msn07082005@gmail.com',
            password='testpassword123',
        )
    def test_forget_password(self):
        url = '/forget-password/'
        response = self.client.post(url,{'email':self.user.email}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
from rest_framework import serializers
from .models import Blog

class BlogSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()

    class Meta:
        model = Blog
        fields = '__all__'
        read_only_fields = ['user', 'date']

    def get_image(self, obj):
        request = self.context.get('request')
        if obj.image and request:
            return request.build_absolute_uri(obj.image.url)
        return None

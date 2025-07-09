from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Blog(models.Model):
    BLOG_TYPES = (
        ('Internship', 'Internship'),
        ('Placement', 'Placement'),
        ('InternEra', 'InternEra'),
        ('ICYDontKnow', 'ICYDontKnow'),
        ('ThenVsNow', 'ThenVsNow'),
        ('SemEx', 'SemEx'),
    )

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    title = models.CharField(max_length=200)
    thought = models.TextField()
    image = models.ImageField(upload_to='blog_images/')
    blog_type = models.CharField(max_length=20, choices=BLOG_TYPES)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.title} ({self.blog_type})"

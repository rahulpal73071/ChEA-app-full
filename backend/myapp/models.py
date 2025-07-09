from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Opportunity(models.Model):
    title = models.CharField(max_length=255)
    stipend = models.CharField(max_length=100)
    location = models.CharField(max_length=255)
    lastDateOfApply = models.DateField()
    domain = models.CharField(max_length=100)
    role = models.CharField(max_length=100)
    description = models.TextField()
    OpportunityType = models.CharField(max_length=100,choices=[('Internship','Internship'),('Placement','Placement'),('Projects','Projects')],default='Internship')

    def __str__(self):
        return self.title

class FavoriteOpportunity(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    opportunity = models.ForeignKey(Opportunity,on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.email} - {self.opportunity.title}"
    
class Blog(models.Model):
    blog_type = models.CharField(max_length=50)
    image_url = models.URLField()
    description = models.TextField()
    subtitle = models.TextField()
    title = models.TextField()
    date = models.DateField()
    name = models.CharField(max_length=50,null=True,blank=True)


class BookmarkedBlog(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    blog = models.ForeignKey(Blog, on_delete=models.CASCADE)
    
    def __str__(self):
        return f"{self.user.email} - {self.blog.title}"

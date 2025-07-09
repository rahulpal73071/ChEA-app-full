
from django.urls import path
from .views import get_opportunities,add_favorite_opportunity,remove_favorite_opportunity,get_favorites


urlpatterns = [
    path('opportunities/', get_opportunities),
    path('add_favorite/', add_favorite_opportunity),
    path('remove_favorite/', remove_favorite_opportunity),
    path('get_favorite/', get_favorites),
]
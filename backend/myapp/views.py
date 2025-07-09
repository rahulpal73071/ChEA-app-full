from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response
from .models import Opportunity,FavoriteOpportunity
from .serializers import OpportunitiesSerializer
from rest_framework import status
from django.db.models import Case, When, Value, BooleanField

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_opportunities(request):
    user = request.user
    opportunities = Opportunity.objects.annotate(
        isFavourite=Case(
            When(favoriteopportunity__user=user, then=Value(True)),
            default=Value(False),
            output_field=BooleanField()
        )
    ).distinct()
    serializer = OpportunitiesSerializer(opportunities, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def add_favorite_opportunity(request):
    user = request.user
    opportunity_id = request.data.get('opportunity_id')
    try:
        opportunity = Opportunity.objects.get(id=opportunity_id)
        favorite, created = FavoriteOpportunity.objects.get_or_create(user=user, opportunity=opportunity)
        if created:
            return Response(status=status.HTTP_201_CREATED)
        else:
            return Response({'message': 'Favorite already exists.'}, status=status.HTTP_200_OK)
    except Opportunity.DoesNotExist:
        return Response({'message': 'Opportunity not found.'}, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def remove_favorite_opportunity(request):
    user = request.user
    opportunity_id = request.data.get('opportunity_id')
    try:
        opportunity = Opportunity.objects.get(id=opportunity_id)
        favorite = FavoriteOpportunity.objects.get(user=user, opportunity=opportunity)
        favorite.delete()
        return Response(status=status.HTTP_200_OK)
    except Opportunity.DoesNotExist:
        return Response({'message': 'Opportunity not found.'}, status=status.HTTP_404_NOT_FOUND)
    except FavoriteOpportunity.DoesNotExist:
        return Response({'message': 'Favorite opportunity not found.'}, status=status.HTTP_404_NOT_FOUND)
    
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_favorites(request):
    user = request.user
    favorites = FavoriteOpportunity.objects.filter(user=user)
    opportunities = [favorite.opportunity for favorite in favorites]
    serializer = OpportunitiesSerializer(opportunities,many=True, context={'always_favourite': True})
    return Response(serializer.data,status=status.HTTP_200_OK)
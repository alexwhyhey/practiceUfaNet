from rest_framework import viewsets, permissions
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework import filters
from partners.models import *
from .serializers import *

class BaseViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

class CategoryViewSet(BaseViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

    class Meta:
        filter_backends = [filters.SearchFilter, filters.OrderingFilter]
        search_fields = ['title']
        ordering_fields = '__all__'

    @action(detail=True, methods=['get'], url_path='offers', url_name='category-offers')
    def get_offers(self, request, pk=None):
        category = self.get_object()
        offers = Offer.objects.filter(
            offertag__tag__categorytag__category=category
        ).distinct().prefetch_related('partner', 'city')
        
        serializer = OfferSerializer(offers, many=True, context={'request': request})
        return Response(serializer.data)

class CityViewSet(BaseViewSet):
    queryset = City.objects.all()
    serializer_class = CitySerializer

class PartnerViewSet(BaseViewSet):
    queryset = Partner.objects.all()
    serializer_class = PartnerSerializer

class OfferViewSet(BaseViewSet):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer

    class Meta:
        filter_backends = [filters.SearchFilter, filters.OrderingFilter]
        search_fields = ['what_offer_about', 'where_to_use', 'how_to_get']
        ordering_fields = '__all__'

class TagViewSet(BaseViewSet):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

class OfferTagViewSet(BaseViewSet):
    queryset = OfferTag.objects.all()
    serializer_class = OfferTagSerializer

class CategoryTagViewSet(BaseViewSet):
    queryset = CategoryTag.objects.all()
    serializer_class = CategoryTagSerializer

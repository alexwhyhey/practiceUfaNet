from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import viewsets, generics
from .models import *
from .serializers import *

# Create your views here.
def main(request):
    return HttpResponse("HelloWorld!")

class CategoryListCreate(generics.ListCreateAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class CategoryRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class CityListCreate(generics.ListCreateAPIView):
    queryset = City.objects.all()
    serializer_class = CitySerializer

class CityRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = City.objects.all()
    serializer_class = CitySerializer

class PartnerListCreate(generics.ListCreateAPIView):
    queryset = Partner.objects.all()
    serializer_class = PartnerSerializer

class PartnerRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = Partner.objects.all()
    serializer_class = PartnerSerializer

class OfferListCreate(generics.ListCreateAPIView):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer

class OfferRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer

class TagListCreate(generics.ListCreateAPIView):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

class TagRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

class OfferTagListCreate(generics.ListCreateAPIView):
    queryset = OfferTag.objects.all()
    serializer_class = OfferTagSerializer

class OfferTagRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = OfferTag.objects.all()
    serializer_class = OfferTagSerializer

class CategoryTagListCreate(generics.ListCreateAPIView):
    queryset = CategoryTag.objects.all()
    serializer_class = CategoryTagSerializer

class CategoryTagRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = CategoryTag.objects.all()
    serializer_class = CategoryTagSerializer

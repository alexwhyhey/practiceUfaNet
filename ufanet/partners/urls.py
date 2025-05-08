from django.urls import path
from .views import *

urlpatterns = [
    path('', main, name='main'),
    path('api/categories/', CategoryListCreate.as_view(), name='category-list-create'),
    path('api/categories/<int:pk>', CategoryRetrieveUpdateDestroy.as_view(), name='category-retrieve-update-destroy'),
    path('api/cities/', CityListCreate.as_view(), name='city-list-create'),
    path('api/cities/<int:pk>', CityRetrieveUpdateDestroy.as_view(), name='city-retrieve-update-destroy'),

    path('api/offers/', OfferListCreate.as_view(), name='offer-list-create'),
    path('api/offers/<int:pk>', OfferRetrieveUpdateDestroy.as_view(), name='offer-retrieve-update-destroy'),
    path('api/tags/', TagListCreate.as_view(), name='tag-list-create'),
    path('api/tags/<int:pk>', TagRetrieveUpdateDestroy.as_view(), name='tag-retrieve-update-destroy'),

    path('api/partners/', PartnerListCreate.as_view(), name='partner-list-create'),
    path('api/partners/<int:pk>', PartnerRetrieveUpdateDestroy.as_view(), name='partner-retrieve-update-destroy'),

    path('api/offer_tags/', OfferTagListCreate.as_view(), name='offer-tag-list-create'),
    path('api/offer_tags/<int:pk>', OfferTagRetrieveUpdateDestroy.as_view(), name='offer-tag-retrieve-update-destroy'),
    path('api/category_tags/', CategoryTagListCreate.as_view(), name='category-tag-list-create'),
    path('api/category_tags/<int:pk>', CategoryTagRetrieveUpdateDestroy.as_view(), name='category-tag-retrieve-update-destroy'),
]

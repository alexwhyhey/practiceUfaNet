from django.urls import path
from .views import *

urlpatterns = [
    path('', main, name='main'),
    path('api/categories/', CategoryListCreate.as_view(), name='category-list-create'),
    path('api/categories/<int:pk>', CategoryRetrieveUpdateDestroy.as_view(), name='category-retrieve-update-destroy'),
    path('api/cities/', CityListCreate.as_view(), name='city-list-create'),
    path('api/cities/<int:pk>', CityRetrieveUpdateDestroy.as_view(), name='city-list-create'),
]

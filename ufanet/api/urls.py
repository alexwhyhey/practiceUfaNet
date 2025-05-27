from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework.routers import DefaultRouter
from django.urls import path, include
from api.views import *

router = DefaultRouter()
router.register(r'categories', CategoryViewSet)
router.register(r'cities', CityViewSet)
router.register(r'partners', PartnerViewSet)
router.register(r'offers', OfferViewSet)
router.register(r'tags', TagViewSet)
router.register(r'offer-tags', OfferTagViewSet)
router.register(r'category-tags', CategoryTagViewSet)

urlpatterns = [
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
] + router.urls


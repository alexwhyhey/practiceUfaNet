from rest_framework import serializers
from .models import *
from django.core.validators import FileExtensionValidator

class CategorySerializer(serializers.ModelSerializer):
    logo = serializers.ImageField(
        required=False,
        allow_null=True,
        use_url=True,
        max_length=None,
        validators=[
            FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'webp'])
        ]
    )

    class Meta:
        model = Category
        fields = ['id', 'title', 'logo']

    def validate_logo(self, file):
        if file and file.size > 2 * 1024 * 1024:
            raise serializers.ValidationError("Image too large")
        return file

class CitySerializer(serializers.ModelSerializer):
    region = serializers.CharField(
        max_length=100,
        required=False,
        allow_null=True,
        allow_blank=True,
        default=None,
    )

    class Meta:
        model = City
        fields = ['id', 'name', 'country', 'region']
        read_only_fields = ['id']

    def validate_region(self, value):
        if value == '':
            return None
        return value

class PartnerSerializer(serializers.ModelSerializer):
    logo = serializers.ImageField(
        required=False,
        allow_null=True,
        use_url=True,
        max_length=None,
        validators=[
            FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'webp'])
        ]
    )

    class Meta:
        model = Category
        fields = ['id', 'title', 'logo', 'about']

    def validate_logo(self, file):
        if file and file.size > 2 * 1024 * 1024:
            raise serializers.ValidationError("Image too large")
        return file

class OfferSerializer(serializers.ModelSerializer):

    
    back_image = serializers.ImageField(
        required=False,
        allow_null=True,
        use_url=True,
        max_length=None,
        validators=[
            FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'webp'])
        ]
    )

    class Meta:
        model = Category
        fields = ['id', 'partner', 'city', 'button_name', 'url', 'what_offer_about', 'where_to_use', 'back_image', 'how_to_get', 'start_date', 'end_date']

    def validate_logo(self, file):
        if file and file.size > 2 * 1024 * 1024:
            raise serializers.ValidationError("Image too large")
        return file
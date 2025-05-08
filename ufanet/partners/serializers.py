from rest_framework import serializers
from .models import *
from django.core.validators import FileExtensionValidator, RegexValidator

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
        model = Partner
        fields = ['id', 'title', 'logo', 'about']
        read_only_fields = ['id']

    def validate_logo(self, file):
        if file and file.size > 2 * 1024 * 1024:
            raise serializers.ValidationError("Image too large")
        return file


class OfferSerializer(serializers.ModelSerializer):
    partner = PartnerSerializer(read_only=True)
    city = CitySerializer(read_only=True)

    partner_id = serializers.PrimaryKeyRelatedField(
        queryset=Partner.objects.all(),
        source='partner',
        write_only=True  
    )
    city_id = serializers.PrimaryKeyRelatedField(
        queryset=City.objects.all(),
        source='city',
        write_only=True  
    )
    
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
        model = Offer
        fields = ['id', 'partner', 'partner_id', 'city', 'city_id', 'button_name', 'url', 'what_offer_about', 'where_to_use', 'back_image', 'how_to_get', 'start_date', 'end_date']
        read_only_fields = ['id']

    def validate_logo(self, file):
        if file and file.size > 2 * 1024 * 1024:
            raise serializers.ValidationError("Image too large")
        return file


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['id', 'name']
        read_only_fields = ['id']
    

class OfferTagSerializer(serializers.ModelSerializer):
    offer = OfferSerializer(read_only=True)
    tag = TagSerializer(read_only=True)

    offer_id = serializers.PrimaryKeyRelatedField(
        queryset=Offer.objects.all(),
        source='offer',
        write_only=True
    )
    tag_id = serializers.PrimaryKeyRelatedField(
        queryset=Tag.objects.all(),
        source='tag',
        write_only=True
    )

    class Meta:
        model = OfferTag
        fields = ['id', 'offer', 'offer_id', 'tag', 'tag_id']
        read_only_fields = ['id']


class CategoryTagSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    tag = TagSerializer(read_only=True)

    category_id = serializers.PrimaryKeyRelatedField(
        queryset=Category.objects.all(),
        source='category',
        write_only=True
    )
    tag_id = serializers.PrimaryKeyRelatedField(
        queryset=Tag.objects.all(),
        source='tag',
        write_only=True
    )

    class Meta:
        model = CategoryTag
        fields = ['id', 'category', 'category_id', 'tag', 'tag_id']
        read_only_fields = ['id']


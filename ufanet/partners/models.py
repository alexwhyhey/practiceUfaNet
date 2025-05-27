from django.db import models
from django.core.exceptions import ValidationError

# Create your models here.
class Category(models.Model):
    title = models.CharField(max_length=100, unique=True)
    logo = models.ImageField(blank=True, null=True, upload_to='categories/%Y/')

    class Meta:
        ordering = ['id', 'title']
        verbose_name_plural = 'Categories'

    def __str__(self):
        return self.title


class City(models.Model):
    name = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    region = models.CharField(max_length=100, blank=True)

    class Meta:
        verbose_name_plural = 'Cities'
        ordering = ['id', 'country', 'name']

    def __str__(self):
        return f'{self.country}, г. {self.name}{f' ({self.region})' if self.region else ''}'


class Partner(models.Model):
    title = models.CharField(max_length=150, unique=True)
    logo = models.ImageField(blank=True, null=True, upload_to='partners/logos/%Y/%m/')
    about = models.TextField(max_length=600)

    class Meta:
        ordering = ['id', 'title']

    def __str__(self):
        return self.title


class Offer(models.Model):
    partner = models.ForeignKey(Partner, on_delete=models.CASCADE, related_name='offers')
    city = models.ForeignKey(City, on_delete=models.CASCADE, related_name='offers')
    button_name = models.CharField(max_length=30)
    url = models.URLField()
    what_offer_about = models.TextField(max_length=100)
    where_to_use = models.TextField(max_length=100)
    back_image = models.ImageField(blank=True, null=True, upload_to='offers/background/%Y/')
    how_to_get = models.TextField(max_length=500)
    start_date = models.DateField()
    end_date = models.DateField()

    def clean(self):
        if self.start_date and self.end_date and self.start_date >= self.end_date:
            raise ValidationError('End date must be after start date.')

    def __str__(self):
        return f'{self.partner.title} - {self.city} - {self.what_offer_about}'


class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)

    class Meta:
        ordering = ['id', 'name']

    def __str__(self):
        return self.name


class OfferTag(models.Model):
    offer = models.ForeignKey(Offer, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)

    class Meta:
        unique_together = ['id', 'offer', 'tag']

    def __str__(self):
        return f'{self.offer.what_offer_about}: {self.offer.where_to_use} - {self.tag}'


class CategoryTag(models.Model):
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    tag = models.ForeignKey(Tag, on_delete=models.CASCADE)

    class Meta:
        unique_together = ['id', 'category', 'tag']

    def __str__(self):
        return f'{self.category.title} - {self.tag}'


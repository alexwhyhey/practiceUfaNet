from django.db import models
from django.core.exceptions import ValidationError

# Create your models here.
class Category(models.Model):
    title = models.CharField(max_length=100, unique=True)
    logo = models.ImageField(blank=True, null=True, upload_to='categories/%Y/')

    class Meta:
        ordering = ['title']
        verbose_name_plural = 'Categories'

    def __str__(self):
        return self.title


class City(models.Model):
    name = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    region = models.CharField(max_length=100, blank=True)

    class Meta:
        verbose_name_plural = 'Cities'
        ordering = ['country', 'name']

    def __str__(self):
        return f'{self.country}, г. {self.name}{f' ({self.region})' if self.region else ''}'


from django.db import models


# Create your models here.
class Category(models.Model):
    Title = models.CharField(max_length=100)
    Logo = models.ImageField(default='')

    def __str__(self):
        return self.Title


class City(models.Model):
    Name = models.CharField(max_length=100)
    Country = models.CharField(max_length=100)
    Region = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.Country}, г. {self.Name} - {self.Region}'


class Partner(models.Model):
    Title = models.CharField(max_length=150)
    Logo = models.ImageField(default='')
    About = models.TextField()

    def __str__(self):
        return self.Title


class Offer(models.Model):
    PartnerID = models.ForeignKey(Partner, on_delete=models.CASCADE)
    CityID = models.ForeignKey(City, on_delete=models.CASCADE)
    ButtonName = models.CharField(max_length=30)
    Url = models.URLField(default='')
    WhatAboutOffer = models.TextField()
    WhereToUse = models.TextField()
    BackPhoto = models.ImageField(default='')
    HowToGet = models.TextField()
    StartDate = models.DateField()
    EndDate = models.DateField()

    def __str__(self):
        return f'{self.PartnerID.Title} - {self.CityID} - {self.WhatAboutOffer}'


class Tag(models.Model):
    Name = models.CharField(max_length=50)

    def __str__(self):
        return self.Name


class OfferTag(models.Model):
    OfferID = models.ForeignKey(Offer, on_delete=models.CASCADE)
    TagID = models.ForeignKey(Tag, on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.OfferID.WhatAboutOffer}: {self.OfferID.WhereToUse} - {self.TagID}'


class CategoryTag(models.Model):
    CategoryID = models.ForeignKey(Category, on_delete=models.CASCADE)
    TagID = models.ForeignKey(Tag, on_delete=models.CASCADE)

    def __str__(self):
        return f'{self.CategoryID.Title} - {self.TagID}'

from django.db import models

# Create your models here.
class Categories(models.Model):
    Title = models.CharField(max_length=100)

    def __str__(self):
        return self.Title
    

class Cities(models.Model):
    Name = models.CharField(max_length=100)
    Country = models.CharField(max_length=100)
    Region = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.Country}, г. {self.Name} - {self.Region}'

class Partners(models.Model):
    Title = models.CharField(max_length=150)
    LogoPath = models.CharField(max_length=100)
    About = models.CharField(max_length=500)

    def __str__(self):
        return self.Title

class Offers(models.Model):
    PartnerID = models.ForeignKey(Partners, on_delete=models.CASCADE)
    CityID = models.ForeignKey(Cities, on_delete=models.CASCADE)
    CategoryID = models.ForeignKey(Categories, on_delete=models.CASCADE)
    ButtonName = models.CharField(max_length=30)
    WhatAboutOffer = models.CharField(max_length=50)
    WhereToUse = models.CharField(max_length=100)
    BackPhotoPath = models.CharField(max_length=150)
    HowToGet = models.CharField(max_length=250)
    StartDate = models.DateField
    EndDate = models.DateField

    def __str__(self):
        return f'{self.PartnerID.Title} - {self.CityID} - {self.CategoryID.Title} - {self.WhatAboutOffer}'


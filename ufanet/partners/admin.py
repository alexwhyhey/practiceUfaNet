from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(City)
admin.site.register(Category)
admin.site.register(Partner)
admin.site.register(Offer)
admin.site.register(Tag)
admin.site.register(OfferTag)
admin.site.register(CategoryTag)

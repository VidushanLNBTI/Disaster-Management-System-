from django.contrib import admin
from app.models import Refugee, Camp, Disaster, Guidelines, Identification, Location, DivisionalSecretariat, GramaNiladhariDivision, Village

# Register your models here.
admin.site.register(Refugee)

class CampAdmin(admin.ModelAdmin):
    list_display = ('name','location','no_of_refugee','casualities','availability_status_of_food','availability_status_of_resources','medical_needs','special_needs','latitude', 'longitude')
admin.site.register(Camp,CampAdmin)

admin.site.register(Disaster)
admin.site.register(Guidelines)
admin.site.register(Identification)
admin.site.register(DivisionalSecretariat)
admin.site.register(GramaNiladhariDivision)
admin.site.register(Village)

class LocationAdmin(admin.ModelAdmin):
    list_display = ('name','latitude', 'longitude')
admin.site.register(Location, LocationAdmin)
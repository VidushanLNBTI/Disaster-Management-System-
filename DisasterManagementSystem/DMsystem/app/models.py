from django.db import models
from django.forms import TextInput, Textarea
from django import forms
import geocoder
from django.contrib.auth.models import User

class Refugee(models.Model):
    name = models.CharField(max_length=45)
    address = models.CharField(max_length=45)
    dob = models.DateField('2002/09/01',null=False)
    age = models.IntegerField(22,null=False)
    class Meta:
        permissions = [("print_refugee", "Can print refugee")]

class Camp(models.Model):
    AVAILABILITY_IN_FOOD_CHOICES = [
        ('Low', 'low'),
        ('Moderate', 'moderate'),
        ('High', 'high')
    ]

    AVAILABILITY_IN_RESOURCES_CHOICES = [
        ('Low', 'low'),
        ('Moderate', 'moderate'),
        ('High', 'high')
    ]
       
    name = models.CharField(max_length=45)
    location = models.CharField(max_length=255, null=True)
    no_of_refugee = models.IntegerField(default=0)
    casualities = models.IntegerField(default=0)
    availability_status_of_food = models.CharField(max_length=10, choices=AVAILABILITY_IN_FOOD_CHOICES)
    availability_status_of_resources= models.CharField(max_length=10, choices=AVAILABILITY_IN_RESOURCES_CHOICES)
    medical_needs = models.CharField(max_length=1000, null=True, blank=True)
    special_needs = models.CharField(max_length=1000, null=True, blank=True)

    latitude = models.FloatField(default=0)
    longitude = models.FloatField(default=0)
    

    def save(self, *args, **kwargs):
        self.latitude = geocoder.osm(self.location).lat
        self.longitude = geocoder.osm(self.location).lng
        
        return super().save(*args, **kwargs)

    class Meta:
        permissions = [("generate_camp_pdf", "Can print camp")]

class Disaster(models.Model):
    description = models.CharField(max_length=45)
    date = models.DateField()
    time = models.TimeField()

class  Guidelines(models.Model):
    before_disaster = models.TextField(max_length=1000)
    during_disaster=models.TextField(max_length=1050)
    after_disaster = models.TextField(max_length=1000)

class Identification(models.Model):
    safety_area = models.CharField(max_length=1000)
    risky_area = models.CharField(max_length=1000)
    affected_area = models.CharField(max_length=1000)

class Location(models.Model):
    name = models.CharField(max_length=255, null=True)
    latitude = models.FloatField(default=0)
    longitude = models.FloatField(default=0)
    

    def save(self, *args, **kwargs):
        self.latitude = geocoder.osm(self.name).lat
        self.longitude = geocoder.osm(self.name).lng
        
        return super().save(*args, **kwargs)

    def __str__(self):
        if self.name is not None:
            return self.name
        else:
            return "Unnamed Location"

class LocationDisaster(models.Model):
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    disaster = models.ForeignKey(Disaster, on_delete=models.CASCADE)
    class Meta:
        permissions = [("print_locationdisaster", "Can print locationdisaster")]

class DivisionalSecretariat(models.Model):
    name = models.CharField(max_length=100)

class GramaNiladhariDivision(models.Model):
    name = models.CharField(max_length=100)

class Village(models.Model):
    name = models.CharField(max_length=100)
    disasters = models.ManyToManyField(Disaster)

class VillageDisaster(models.Model):
    village = models.ForeignKey(Location, on_delete=models.CASCADE)
    disaster = models.ForeignKey(Disaster, on_delete=models.CASCADE)
    class Meta:
        permissions = [("print_villagedisaster", "Can print villagedisaster")]

class WaterLevel(models.Model):
    location = models.ForeignKey(Location, on_delete=models.CASCADE)
    timestamp = models.DateTimeField()
    water_level = models.FloatField()

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    contact_number1 = models.CharField(max_length=20, blank=True, null=True)
    contact_number2 = models.CharField(max_length=20, blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    profile_image = models.ImageField(upload_to='profile_images/', blank=True, null=True)

    def __str__(self):
        return self.user.username
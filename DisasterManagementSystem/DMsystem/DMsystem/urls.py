"""DMsystem URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from app import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('app/', include('app.urls')),
    path("accounts/", include("django.contrib.auth.urls")),
    path("accounts/profile/",views.viewprofile, name='profile'),
    path('', views.homepage, name = 'home'),
    path('register/', views.registeruser, name='register'),
    path('accounts/register/', views.registeruser, name='register'),
    path('index/', views.index, name='map'),
    path('guidelines/', views.guidelines, name = 'guidelines'),
    path('donate/', views.donate, name = 'donate'),
    path('refugee_in_camp/', views.refugee_in_camp, name='refugee_in_camp'),
    path('weatherforcast/', views.weatherforcast, name = 'weatherforcast'),
    # path('weatherreport/', views.weatherreport, name = 'weatherreport'),
]




   

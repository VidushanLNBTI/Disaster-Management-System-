from django.urls import path
from app import views
from app.views import RefugeeListView, RefugeeDetailView, RefugeeCreateView, RefugeeUpdateView, RefugeeDeleteView
from app.views import CampListView, CampDetailView, CampCreateView, CampUpdateView, CampDeleteView
from app.views import DisasterListView, DisasterDetailView, DisasterCreateView, DisatserUpdateView, DisasterDeleteView
from app.views import GuidelinesListView, GuidelinesDetailView, GuidelinesCreateView, GuidelinesUpdateView, GuidelinesDeleteView
from app.views import IdentificationListView, IdentificationCreateView, IdentificationDetailView, IdentificationUpdateView, IdentificationDeleteView
from app.views import LocationListView, LocationCreateView, LocationDetailView, LocationUpdateView, LocationDeleteView
from app.views import DivisionalSecretariatListView, DivisionalSecretariatCreateView, DivisionalSecretariatDetailView, DivisionalSecretariatUpdateView, DivisionalSecretariatDeleteView
from app.views import GramaNiladhariDivisionListView, GramaNiladhariDivisionCreateView, GramaNiladhariDivisionDetailView, GramaNiladhariDivisionUpdateView, GramaNiladhariDivisionDeleteView
from app.views import VillageListView, VillageCreateView, VillageDetailView, VillageUpdateView, VillageDeleteView,edit_profile,upload_water_level
from django.contrib.auth.decorators import login_required
from .views import generate_camp_pdf

urlpatterns = [
    path('refugeelistview', RefugeeListView.as_view(), name='refugee_index'),
    path('refugeedetailview/<int:pk>', RefugeeDetailView.as_view(), name='refugee_details'),

    path('refugeecreateview', RefugeeCreateView.as_view(), name='create_refugee'),
    path('refugeeupdateview/<int:pk>', RefugeeUpdateView.as_view(), name='refugee_update'),

    path('refugeedeleteview/<int:pk>', RefugeeDeleteView.as_view(), name='refugee_delete'),

    path('camplistview', login_required(CampListView.as_view()), name='camp_index'),
    path('campdetailview/<int:pk>', CampDetailView.as_view(), name='camp_details'),

    path('campcreateview', CampCreateView.as_view(), name='create_camp'),
    path('campupdateview/<int:pk>', CampUpdateView.as_view(), name='camp_update'),

    path('campdeleteview/<int:pk>', CampDeleteView.as_view(), name='camp_delete'),

    path('', views.camp_create),
    path('', views.refugee_create),

    path('disasterlistview', login_required(DisasterListView.as_view()), name='disaster_index'),
    path('disasterdetailview/<int:pk>', DisasterDetailView.as_view(), name='disaster_details'),

    path('disastercreateview', DisasterCreateView.as_view(), name='create_disaster'),
    path('disasterupdateview/<int:pk>', DisatserUpdateView.as_view(), name='disaster_update'),

    path('disasterdeleteview/<int:pk>', DisasterDeleteView.as_view(), name='disaster_delete'),

    path('guidelineslistview', login_required(GuidelinesListView.as_view()), name='guidelines_index'),
    path('guidelinesdetailview/<int:pk>', GuidelinesDetailView.as_view(), name='guidelines_details'),

    path('guidelinescreateview', GuidelinesCreateView.as_view(), name='create_guidelines'),
    path('guidelinesupdateview/<int:pk>', GuidelinesUpdateView.as_view(), name='guidelines_update'),

    path('guidelinesdeleteview/<int:pk>', GuidelinesDeleteView.as_view(), name='guidelines_delete'),

    path('identificationlistview', IdentificationListView.as_view(), name='identification_index'),
    path('identificationdetailview/<int:pk>', IdentificationDetailView.as_view(), name='identification_details'),

    path('identificationcreateview', IdentificationCreateView.as_view(), name='create_identification'),
    path('identificationupdateview/<int:pk>', IdentificationUpdateView.as_view(), name='identification_update'),

    path('identificationdeleteview/<int:pk>', IdentificationDeleteView.as_view(), name='identification_delete'),

    path('locationlistview',  login_required(LocationListView.as_view()), name='location_index'),
    path('locationdetailview/<int:pk>', LocationDetailView.as_view(), name='location_details'),

    path('locationcreateview', LocationCreateView.as_view(), name='create_location'),
    path('locationupdateview/<int:pk>', LocationUpdateView.as_view(), name='location_update'),

    path('locationdeleteview/<int:pk>', LocationDeleteView.as_view(), name='location_delete'),

    path('divisionalsecretariatlistview', DivisionalSecretariatListView.as_view(), name='divisionalsecretariat_index'),
    path('divisionalsecretariatdetailview/<int:pk>', DivisionalSecretariatDetailView.as_view(), name='divisionalsecretariat_details'),

    path('divisionalsecretariatcreateview', DivisionalSecretariatCreateView.as_view(), name='create_divisionalsecretariat'),
    path('divisionalsecretariatupdateview/<int:pk>', DivisionalSecretariatUpdateView.as_view(), name='divisionalsecretariat_update'),

    path('divisionalsecretariatdeleteview/<int:pk>', DivisionalSecretariatDeleteView.as_view(), name='divisionalsecretariat_delete'),

    path('gramaniladharidivisionlistview', GramaNiladhariDivisionListView.as_view(), name='gramaniladharidivisional_index'),
    path('gramaniladharidivisiondetailview/<int:pk>', GramaNiladhariDivisionDetailView.as_view(), name='gramaniladharidivisional_details'),

    path('gramaniladharidivisioncreateview', GramaNiladhariDivisionCreateView.as_view(), name='create_gramaniladharidivision'),
    path('gramaniladharidivisionupdateview/<int:pk>', GramaNiladhariDivisionUpdateView.as_view(), name='gramaniladharidivisional_update'),

    path('gramaniladharidivisiondeleteview/<int:pk>', GramaNiladhariDivisionDeleteView.as_view(), name='gramaniladharidivisional_delete'),

    path('villagelistview', VillageListView.as_view(), name='village_index'),
    path('villagedetailview/<int:pk>', VillageDetailView.as_view(), name='village_details'),

    path('villagecreateview', VillageCreateView.as_view(), name='create_village'),
    path('villageupdateview/<int:pk>', VillageUpdateView.as_view(), name='village_update'),

    path('villagedeleteview/<int:pk>', VillageDeleteView.as_view(), name='village_delete'),

    path('accounts/register/', views.registeruser, name='registeruser'),
    
    path('flood_guidelines/', views.flood_guidelines, name = 'flood_guidelines'),
    path('landslide_guidelines/', views.landslide_guidelines, name = 'landslide_guidelines'),
    path('wildfire_guidelines/', views.wildfire_guidelines, name = 'wildfire_guidelines'),
    path('refugee_in_camp/<int:refugee_id>/', views.refugee_in_camp, name='refugee_in_camp'),

    path('activate/<uidb64>/<token>', views.activate, name='activate'),
    path('accounts/profile/', views.profile),
    path('guidelines/', views.guidelines),
    path('edit_profile/', edit_profile, name='edit_profile'),
    path('generate_camp_pdf/', views.generate_camp_pdf, name='generate_camp_pdf'),
    path('upload_water_level/', upload_water_level, name='upload_water_level'),
    path('home', views.sendemail, name="sendemail"),
    path('transactions/', views.transactions, name='transactions'),
]

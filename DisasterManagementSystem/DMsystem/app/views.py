from django.http import JsonResponse
from django.shortcuts import render, redirect,redirect
from app.models import Refugee, Camp, Guidelines, Disaster, Identification, Location, LocationDisaster, DivisionalSecretariat, GramaNiladhariDivision, Village
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.template.response import TemplateResponse
from django.http import HttpResponse
from .forms import DisasterForm, LocationForm, VillageForm,UserProfileForm
from django.forms.models import inlineformset_factory
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test, permission_required
from django.contrib.auth.mixins import PermissionRequiredMixin
import folium 
from folium import plugins
from .forms import CampForm, RefugeeForm
from .models import *
from .forms import CreateUserForm
from django.template.loader import render_to_string
from django.contrib.sites.shortcuts import get_current_site
from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from django.utils.encoding import force_bytes, force_str
from django.core.mail import EmailMessage
from .tokens import account_activation_token
import pandas as pd
from django.conf import settings
from django.contrib.auth import update_session_auth_hash
from django.urls import reverse_lazy
import io
from django.http import FileResponse
from reportlab.pdfgen import canvas
from django.template.loader import get_template
from django.template import Context
from xhtml2pdf import pisa
from django.utils.safestring import mark_safe  
from django.db.models import F
from django.db.models.functions import Power, Sqrt
from .forms import WaterLevelUploadForm
from .models import WaterLevel
from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType
from django.db.models.signals import post_migrate

class RefugeeListView(PermissionRequiredMixin, ListView):
    permission_required = 'app.view_refugee'
    template_name_suffix = "_index"
    model = Refugee
    paginate_by = 20

class RefugeeDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Refugee

class RefugeeCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_refugee'
    model = Refugee
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'refugeelistview'

class RefugeeUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_refugee'
    model = Refugee
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/refugeelistview'

class RefugeeDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_refugee'
    model = Refugee
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/refugeelistview'

class CampListView(ListView):
    permission_required = 'app.view_camp'
    template_name_suffix = "_index"
    model = Camp
    paginate_by = 8

class CampDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Camp

class CampCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_camp'
    template_name = 'app/camp_create.html'
    form_class = CampForm
    success_message = "Camp was created successfully."

    def form_valid(self, form):
        form.save()
        messages.success(self.request, 'Camp was created successfully.')
        return super().form_valid(form)
    def form_invalid(self, form):
        messages.error(self.request, 'Failed to create the camp. Please fill the required fields.')
        return super().form_invalid(form)
    def get_success_url(self):
        return reverse_lazy('create_camp')

class CampUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_camp'
    model = Camp
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/camplistview'

class CampDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_camp'
    model = Camp
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/camplistview'

class DisasterListView(ListView):
    permission_required = 'app.view_disaster'
    template_name_suffix = "_index"
    model = Disaster
    paginate_by = 3

class DisasterDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Disaster

class DisasterCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_disaster'
    model = Disaster
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'disasterlistview'

class DisatserUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_disaster'
    model = Disaster
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/disasterlistview'

class DisasterDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_disaster'
    model = Disaster
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/disasterlistview'

def disaster(request, pk=None):
    model = Disaster.objects.get(pk=pk) if pk else Disaster()
    data = Disaster.objects.all()

    if request.POST.get('save'):
        form = DisasterForm(request.POST, instance = model) 
        if form.is_valid():
            form.save()
            return redirect('/app/disasters')
    else:

        form = DisasterForm(instance=model)

        if request.POST:
            model.delete()
            return redirect('/app/disasters')
        
    context = {'form':form, 'data':data}
    return render(request, 'disaster_create.html', context)

def location(request, pk=None):
    model = Location.objects.get(pk=pk) if pk else Location()
    data = Location.objects.all()
    
    if request.POST.get('save'):
        form = LocationForm(request.POST, instance = model) 
        
        if form.is_valid():
            form.save()
            return redirect('/app/locations')

    else:
        form = LocationForm(instance=model)

        if request.POST:
            model.delete()
            return redirect('/app/locations')

    context = {'form':form, 'data':data}
    return render(request, 'location_create.html', context)

def village(request, pk=None):
    model = village.objects.get(pk=pk) if pk else Village()
    data = village.objects.all()

    if request.POST.get('save'):
        form = VillageForm(request.POST, instance = model) 

        if form.is_valid():
            form.save()
            return redirect('/app/villages')

    else:
        form = VillageForm(instance=model)

        if request.POST:
            model.delete()
            return redirect('/app/villages')

    context = {'form':form, 'data':data}
    return render(request, 'village_create.html', context)

class GuidelinesListView(ListView):
    permission_required = 'app.view_guidelines'
    template_name_suffix = "_index"
    model = Guidelines
    paginate_by = 3

class GuidelinesDetailView(DetailView):
    template_name_suffix = "_show"
    model = Guidelines

class GuidelinesCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_guidelines'
    model = Guidelines
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'guidelineslistview'

class GuidelinesUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_guidelines'
    model = Guidelines
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/guidelineslistview'

class GuidelinesDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_guidelines'
    model = Guidelines
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/guidelineslistview'

class IdentificationListView(PermissionRequiredMixin, ListView):
    permission_required = 'app.view_identification'
    template_name_suffix = "_index"
    model = Identification
    paginate_by = 3

class IdentificationDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Identification

class IdentificationCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_identification'
    model = Identification
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'identificationlistview'

class IdentificationUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_identification'
    model = Identification
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/identificationlistview'

class IdentificationDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_identification'
    model = Identification
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/identificationlistview'

class LocationListView(ListView):
    permission_required = 'app.view_location'
    template_name_suffix = "_index"
    model = Location
    paginate_by = 3

class LocationDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Location
    
class LocationCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_location'
    template_name = 'app/location_create.html'
    form_class = LocationForm
    success_message = "Location was created successfully."
    def form_valid(self, form):
        form.save()
        messages.success(self.request, 'Location was created successfully.')
        return super().form_valid(form)
    def form_invalid(self, form):
        messages.error(self.request, 'Failed to create the location. Please fill the fields.')
        return super().form_invalid(form)
    def get_success_url(self):
        return reverse_lazy('create_location')
    
class LocationUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_location'
    model = Location
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/locationlistview'

class LocationDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_location'
    model = Location
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/locationlistview'

class DivisionalSecretariatListView(PermissionRequiredMixin, ListView):
    permission_required = 'app.view_divisionalsecretariat'
    template_name_suffix = "_index"
    model = DivisionalSecretariat
    paginate_by = 3

class DivisionalSecretariatDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = DivisionalSecretariat

class DivisionalSecretariatCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_divisionalsecretariat'
    model = DivisionalSecretariat
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'divisionalsecretariatlistview'

class DivisionalSecretariatUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_divisionalsecretariat'
    model = DivisionalSecretariat
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/divisionalsecretariatlistview'

class DivisionalSecretariatDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_divisionalsecretariat'
    model = DivisionalSecretariat
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/divisionalsecretariatlistview'

class GramaNiladhariDivisionListView(PermissionRequiredMixin, ListView):
    permission_required = 'app.view_gramaniladharidivision'
    template_name_suffix = "_index"
    model = GramaNiladhariDivision
    paginate_by = 3

class GramaNiladhariDivisionDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = GramaNiladhariDivision

class GramaNiladhariDivisionCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_gramaniladharidivision'
    model = GramaNiladhariDivision
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'gramaniladharidivisionlistview'

class GramaNiladhariDivisionUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_gramaniladharidivision'
    model = GramaNiladhariDivision
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/gramaniladharidivisionlistview'

class GramaNiladhariDivisionDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_gramaniladharidivision'
    model = GramaNiladhariDivision
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/gramaniladharidivisionlistview'

class VillageListView(PermissionRequiredMixin, ListView):
    permission_required = 'app.view_village'
    template_name_suffix = "_index"
    model = Village
    paginate_by = 3

class VillageDetailView(PermissionRequiredMixin, DetailView):
    template_name_suffix = "_show"
    model = Village

class VillageCreateView(PermissionRequiredMixin, CreateView):
    permission_required = 'app.add_village'
    model = Village
    fields = '__all__'
    template_name_suffix = "_create"
    success_url = 'villagelistview'

class VillageUpdateView(PermissionRequiredMixin, UpdateView):
    permission_required = 'app.update_village'
    model = Village
    fields = '__all__'
    template_name_suffix = "_update"
    success_url = '../../app/villagelistview'

class VillageDeleteView(PermissionRequiredMixin, DeleteView):
    permission_required = 'app.delete_village'
    model = Village
    fields = '__all__'
    template_name_suffix = "_delete"
    success_url = '../../app/villagelistview'

def camp_create(request):
    return render(request, 'app/camp_create.html')

def refugee_create(request):
    return render(request, 'app/refugee_create.html')

@login_required
def viewprofile(request):
    return TemplateResponse(request, 'profile.html')

def homepage(request):
    return TemplateResponse(request, 'home.html')

def activate(request, uidb64, token):
    return redirect('login')

def activateEmail(request, user, to_email):
    mail_subject = "Activate your user account."
    message = render_to_string("template_activate_account.html",{
        'user': user.username,
        'domain': get_current_site(request).domain,
        'uid': urlsafe_base64_encode(force_bytes(user.pk)),
        'token': account_activation_token.make_token(user),
        "protocol": 'http' if request.is_secure() else 'http'
    })
    email = EmailMessage(mail_subject, message, to=[to_email])
    if email.send():
        message = mark_safe(f'Dear {user},  please go to your email <b>{to_email}</b> inbox and click on\
                    received activation link to confirm and complete the registration. <b>Note:</b> Check your spam folder.')
        messages.success(request, message)
    else:
        messages.error(request, f'Problem sending email to {to_email}, check if you typed it correctly.')

@user_passes_test(lambda u:not u.is_authenticated) 
def registeruser(request):
    form=CreateUserForm
    if request.method == 'POST':
        form = CreateUserForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_active
            user.save()
            activateEmail(request, user, form.cleaned_data.get('email'))

            user = form.cleaned_data.get('username')
            messages.success(request, 'Account was created for '+user)
            return redirect('login')
        
        else:
            for error in list(form.errors.values()):
                messages.error(request, error)

    return render(
        request=request,
        template_name="registrationform.html",
        context={"form":form}
    )            

def profile(request):
    if request.user.is_authenticated:
        return render(request, 'profile.html')
    else:
        return redirect('/login_page/')
def edit_profile(request):
    user = request.user

    if request.method == 'POST':
        request.user.first_name = request.POST.get('first_name')
        request.user.last_name = request.POST.get('last_name')
        request.user.save()

        # Update custom fields in the UserProfile model
        user_profile, created = UserProfile.objects.get_or_create(user=request.user)
        user_profile.contact_number1 = request.POST.get('contact_number1')
        user_profile.contact_number2 = request.POST.get('contact_number2')
        user_profile.address = request.POST.get('address')

        # Handle profile image upload
        if 'profile_image' in request.FILES:
            user_profile.profile_image = request.FILES['profile_image']

        user_profile.save()
    
        form = UserProfileForm(request.POST)

        if form.is_valid():
            # Verify the current password
            current_password = form.cleaned_data['current_password']
            if not user.check_password(current_password):
                form.add_error('current_password', 'Incorrect current password')
            else:
                # Update user details
                user.username = form.cleaned_data['username']
                user.email = form.cleaned_data['email']
                if form.cleaned_data['new_password']:
                    user.set_password(form.cleaned_data['new_password'])
                    update_session_auth_hash(request, user)  # Update session to prevent logout
                user.save()
                messages.success(request, 'Profile updated successfully.')
                # Redirect to a success page 
                return redirect('edit_profile')
    else:
        form = UserProfileForm(initial={
            'username': user.username,
            'email': user.email,
        })

    return render(request, 'edit_profile.html', {'form': form})

def index(request):
    data = Location.objects.all()
    data1 = Camp.objects.all()
    location_list = Location.objects.values_list('latitude', 'longitude')
    camp_list = Camp.objects.values_list('latitude', 'longitude')
    map = folium.Map(location=[6.927079, 79.861244], tiles='OpenStreetMap', zoom_start=9)
    # Add markers for locations
    for location in data:
        popup_content = f"<b>Flood Hazard at {location.name}</b><br>"
        iframe = folium.IFrame(html=popup_content, width=160, height=60)
        popup = folium.Popup(iframe, max_width=300)
        folium.Marker([location.latitude, location.longitude], popup=popup, icon=folium.Icon(icon="flash", color='red')).add_to(map)
    # Add markers for camps with a different icon
    for camp in data1:
        popup_content = f"<u><b>{camp.name}</b></u><br>"
        popup_content += f"No. of Refugees: {camp.no_of_refugee}<br>"
        popup_content += f"Casualties: {camp.casualities}<br>"
        popup_content += f"Food Availability: {camp.get_availability_status_of_food_display()}<br>"
        popup_content += f"Resource Availability: {camp.get_availability_status_of_resources_display()}<br>"
        popup_content += f"Medical Needs: {camp.medical_needs}<br>"
        popup_content += f"Special Needs: {camp.special_needs}<br>"
        iframe = folium.IFrame(html=popup_content, width=250, height=150)
        popup = folium.Popup(iframe, max_width=300)
        folium.Marker([camp.latitude, camp.longitude], popup=popup, icon=folium.Icon(icon="home", color='blue')).add_to(map)
    # Get user's location 
    user_latitude = request.GET.get('user_latitude', None)
    user_longitude = request.GET.get('user_longitude', None)

    # Display user's location on the map if available
    if user_latitude is not None and user_longitude is not None:
        user_location = [float(user_latitude), float(user_longitude)]
        display_user_location_on_map(map, user_location)
        # Find the nearest camp and draw a line
        nearest_camp = find_nearest_camp(user_location, data1)
        if nearest_camp:
            draw_line_between_points(map, user_location, [nearest_camp.latitude, nearest_camp.longitude])
    # Add HeatMap layers
    plugins.HeatMap(location_list).add_to(map)
    plugins.HeatMap(camp_list).add_to(map)
    # Convert map to HTML
    map_html = map._repr_html_()
    context = {'map': map_html}
    return render(request, 'index.html', context)

def display_user_location_on_map(map, user_location):
    user_marker = folium.Marker(user_location, popup="Your Location", icon=folium.Icon(icon="user", color="green"))
    user_marker.add_to(map)

def find_nearest_camp(user_location, camps):
    nearest_camp = None
    min_distance = float('inf')
    for camp in camps:
        camp_location = [camp.latitude, camp.longitude]
        distance = calculate_distance(user_location, camp_location)
        if distance < min_distance:
            min_distance = distance
            nearest_camp = camp
    return nearest_camp

def calculate_distance(point1, point2):
    return ((point1[0] - point2[0]) ** 2 + (point1[1] - point2[1]) ** 2) ** 0.5

def draw_line_between_points(map, point1, point2):
    folium.PolyLine([point1, point2], color="blue", weight=3, opacity=1).add_to(map)

# TODO : Implement system to upload water level details to display on the map and generate grapghs.
@permission_required('upload_water_level')
def upload_water_level(request):
    if request.method == 'POST':
        form = WaterLevelUploadForm(request.POST, request.FILES)
        if form.is_valid():
            file = request.FILES['file']

            # Process the uploaded CSV file 
            try:
                df = pd.read_csv(file)

                df.columns = df.columns.str.strip()

                # Filter out rows where 'Year' is not numeric
                df = df[df['Year'].apply(lambda x: str(x).isdigit())]

                # Assuming columns for year, month, and date together represent a unique identifier
                for index, row in df.iterrows():
                    year = row['Year']
                    month = row['Month']
                    date = row['Date']

                    # Find the corresponding location based on the unique identifier
                    location = Location.objects.get(year=year, month=month, date=date)

                    # Create or update WaterLevel entry
                    WaterLevel.objects.update_or_create(
                        location=location,
                        timestamp=f"{year}-{month:02d}-{date:02d}",  # Assuming timestamp is a string like '2024-01-01'
                        defaults={'water_level': row['1']}
                    )

                messages.success(request, 'Water level data uploaded successfully.')
            except Exception as e:
                messages.error(request, f'Failed to process the file. Error: {str(e)}')

            return redirect('map')
    else:
        form = WaterLevelUploadForm()

    context = {'form': form}
    return render(request, 'upload_water_level.html', context)


@login_required
def guidelines(request):
    return TemplateResponse(request, 'guidelines.html')

def flood_guidelines(request):
    return render(request, 'flood_guidelines.html')

def wildfire_guidelines(request):
    return render(request, 'wildfire_guidelines.html')

def landslide_guidelines(request):
    return render(request, 'landslide_guidelines.html')

def donate(request):
    return render(request, 'donate_main.html')

def transactions(request):
    return render(request, 'transactions.html')

def weatherforcast(request):
    return render(request, 'weatherforcast.html')

def refugee_in_camp(request, refugee):
    if request.method == 'POST':
        camp_form = CampForm(request.POST)
        refugee_form = RefugeeForm(request.POST)
        if camp_form.is_valid() and refugee_form.is_valid():
            # Save both forms if they are valid
            camp = camp_form.save()
            refugee = refugee_form.save()
            return render(request, 'refugee_in_camp.html', {'camp': camp, 'refugee': refugee})
    else:
        camp_form = CampForm()
        refugee_form = RefugeeForm()
    
    return render(request, 'data_input.html', {'camp_form': camp_form, 'refugee_form': refugee_form})

@permission_required('app.generate_camp_pdf', raise_exception=True)
def generate_camp_pdf(request):
    camps = Camp.objects.all()

    # Create a context dictionary with the camps
    context = {'object_list': camps}  # Match the variable name used in the template

    # Render the HTML template
    template = get_template('app/camp_show.html')
    html = template.render(context)

    # Create a file-like buffer to receive PDF data.
    buffer = io.BytesIO()

    # Create the PDF object, using the buffer as its "file."
    pisa_status = pisa.CreatePDF(html, dest=buffer)

    if pisa_status.err:
        return HttpResponse('We had some errors <pre>' + html + '</pre>')
    
    buffer.seek(0)
    return FileResponse(buffer, as_attachment=True, filename="camp_details.pdf")

def create_custom_permission(sender, **kwargs):
    content_type = ContentType.objects.get_for_model(Camp)  
    permission, created = Permission.objects.get_or_create(
        codename='download_camp_pdf',
        name='Can print camp',
        content_type=content_type,
    )

# Connect the create_custom_permission function to the post_migrate signal
post_migrate.connect(create_custom_permission, sender=Camp)

def sendemail(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        message = request.POST.get('message')

        content = f"Name: {name}\nEmail: {email}\nMessage: {message}"

        try:
            email = EmailMessage(
                'Contact Form of Disaster Management System',
                content,
                settings.EMAIL_FROM,
                ['vidushanprabash6@gmail.com', 'hasithikeshi17@gmail.com'],
                reply_to=[email],
            )

            email.send()
            messages.success(request, 'We recieved your message. Thank you for connecting with us.')
            return redirect('home')
        
        except Exception as e:
            messages.error(request, f"Error sending email: {str(e)}")
            return HttpResponse("Error sending email")

    return render(request, 'home.html')
from django.forms import ModelForm, Form
from app.models import Refugee,Camp, Disaster, Guidelines, Identification, Location, DivisionalSecretariat, GramaNiladhariDivision, Village
from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.core.validators import RegexValidator

class CreateUserForm(UserCreationForm):
    password_validators = [
        RegexValidator(
            regex='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[0-9a-zA-Z!@#$%^&*()_+]{8,}$',
            message='Password must contain at least 8 characters, one digit, one uppercase letter, one lowercase letter, and one special character.',
        ),
    ]

    password1 = forms.CharField(
        label="Password",
        widget=forms.PasswordInput(attrs={'class': 'inputclass'}),
        validators=password_validators,
        help_text="Password must contain at least 8 characters, one digit, one uppercase letter, one lowercase letter, and one special character."
    )

    password2 = forms.CharField(
        label="Confirm Password",
        widget=forms.PasswordInput(attrs={'class': 'inputclass'}),
        help_text="Enter the same password as above, for verification."
    )

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']
        widgets = {
            'username': forms.TextInput(attrs={'class': 'inputclass'}),
            'email': forms.TextInput(attrs={'class': 'inputclass'}),
            'password1': forms.PasswordInput(attrs={'class': 'inputclass'}),
            'password2': forms.PasswordInput(attrs={'class': 'inputclass'}),
        }

class UserProfileForm(forms.Form):
    username = forms.CharField(max_length=100, required=True)
    email = forms.EmailField(required=True)
    current_password = forms.CharField(widget=forms.PasswordInput, required=True)
    new_password = forms.CharField(
        widget=forms.PasswordInput,
        required=False, 
        validators=[
            RegexValidator(
                regex='^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[0-9a-zA-Z!@#$%^&*()_+]{8,}$',
                message='Password must contain at least 8 characters, including one letter and one number.',
                code='invalid_password'
            ),
        ]
    )
    contact_number1 = forms.CharField(
        max_length=15,
        required=True,
        validators=[
            RegexValidator(
                regex=r'^(\+94\d{9}|0\d{9})$',  
                message='Enter a valid contact number.',
                code='invalid_contact_number'
            ),
        ]
    )
    contact_number2 = forms.CharField(
        max_length=15,
        required=True,
        validators=[
            RegexValidator(
                regex=r'^(\+94\d{9}|0\d{9})$', 
                message='Enter a valid contact number.',
                code='invalid_contact_number'
            ),
        ]
    )
    address = forms.CharField(widget=forms.Textarea, required=False)


class RefugeeForm(ModelForm):
    dob = forms.DateField(
        widget=forms.DateInput(format='%d/%m/%Y/'),
        input_formats=['%m/%d/%Y', '%Y-%m-%d', '%m/%d/%y', '%d/%m/%Y', '%d/%m/%y'],
    )
    class Meta:
        model = Refugee
        fields = "__all__"
    
class CampForm(ModelForm):
    class Meta:
        model = Camp
        fields = ['name','location','no_of_refugee','casualities','availability_status_of_food','availability_status_of_resources','medical_needs','special_needs']
        widgets={
            'availability_status_of_food':forms.Select(attrs={'class':'form-control'}),
            'availability_status_of_resources':forms.Select(attrs={'class':'form-control'})
        }
        
class DisasterForm(ModelForm):
    class Meta:
        model = Disaster
        fields = "__all__"

class GuidelinesForm(ModelForm):
    class Meta:
        model = Guidelines
        fields = "__all__"  

class DisasterForm(forms.ModelForm):
    class Meta:
        model = Disaster
        fields = ('description',)
        widgets = {
            'description': forms.Select(attrs={'class': 'form-control'}),
        }
    
class IdentificationForm(ModelForm):
    class Meta:
        model = Identification
        fields = "__all__"

class LocationForm(ModelForm):
    class Meta:
        model = Location
        fields = ['name']

class DivisionalSecretariatForm(ModelForm):
    class Meta:
        model = DivisionalSecretariat
        fields = "__all__"

class GramaNiladhariDivisionForm(ModelForm):
    class Meta:
        model = GramaNiladhariDivision
        fields = "__all__"

class VillageForm(ModelForm):
    class Meta:
        model = Village
        fields = "__all__"

class WaterLevelUploadForm(forms.Form):
    file = forms.FileField()
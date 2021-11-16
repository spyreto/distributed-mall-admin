from django import forms
from django.core.mail import send_mail
import logging

from django.contrib.auth.forms import (
    UserCreationForm as DjangoUserCreationForm
)
from django.contrib.auth.forms import UsernameField
from django.contrib.auth import authenticate
from . import models
from . import widgets

from django_google_maps.widgets import GoogleMapsAddressWidget
from django.forms import ModelForm

from django.core.exceptions import ObjectDoesNotExist

from django.forms import modelformset_factory

from bootstrap_datepicker_plus import DatePickerInput

logger = logging.getLogger(__name__)

from datetime import datetime, timedelta

from django.utils import timezone

# Sign in form.
class AuthenticationForm(forms.Form):
    email = forms.EmailField()
    password = forms.CharField(strip=False, widget=forms.PasswordInput)

    def __init__(self, request=None, *args, **kwargs):
        self.request = request
        self.user = None
        super().__init__(*args, **kwargs)

    def clean(self):
        email = self.cleaned_data.get("email")
        password = self.cleaned_data.get("password")
        if email is not None and password:
            self.user = authenticate(
                self.request, email=email, password=password
            )
            if self.user is None:
               raise forms.ValidationError('Wrong email or password.')
            if self.user.is_customer:
                raise forms.ValidationError('The website is exclusively for professional sellers.')
            logger.info("Authentication successful for email=%s", email)

        return self.cleaned_data

    def get_user(self):
        return self.user

# Register form.
class SellerCreationForm(DjangoUserCreationForm):
    class Meta(DjangoUserCreationForm.Meta):
        model = models.User
        fields = ('email', 'first_name', 'last_name',)
        field_classes = {"email": UsernameField}

    def save(self):
        user = super().save(commit=False)
        user.is_seller = True
        user.save()
        seller = models.Seller.objects.create(user=user)
        return user

    def send_mail(self):
        logger.info(
            "Sending signup email for email=%s",
            self.cleaned_data["email"],
        )
        message = "Welcome {}".format(self.cleaned_data["email"])
        send_mail(
            "Welcome to the application Distributed Mall",
            message,
            "site@distributedmall.domain",
            [self.cleaned_data["email"]],
            fail_silently=True,
        )

# Μanagement and processing of vendor data form.
class AccountManagementSellerForm(ModelForm):
    class Meta:
        model  = models.User
        fields = {'email', 'first_name','last_name',}

    def clean(self):
        email = self.cleaned_data.get("email")

        if email is not None:
            if models.User.objects.exclude(pk=self.instance.pk).filter(email=email).exists():
                raise forms.ValidationError(u'The email "%s" already used' % email)
        else:
            raise forms.ValidationError("Wrong email.")

        return self.cleaned_data

# Manage data related to the Company model (company details).
class AccountManagementCompanyForm(ModelForm):
    class Meta:
        model = models.Company
        fields = {'description','name', 'category',}

    def clean(self):
        name = self.cleaned_data.get("name")
        description = self.cleaned_data.get("description")
        category= self.cleaned_data.get("category")

        if not name:
            raise forms.ValidationError("Enter your business name.")

        if not description:
            raise forms.ValidationError("Enter a description for your business.")

        if not category:
            raise forms.ValidationError("Please select your business category.")
        else:
            if category.get_descendants():
                raise forms.ValidationError(u'Please enter one of the final subcategories of the "%s" category you selected.' % category.name)

        return self.cleaned_data

# Manage data related to the Location model (company location).
class AccountManagementLocationForm(ModelForm):
    class Meta:
        model = models.CompanyLocation
        fields = {'address', 'geolocation',}
        widgets = {
            "address": widgets.GoogleMapApi(),
        }

# Product_manage management form for product processing.
class SalesProductForm(ModelForm):
    class Meta:
        model  = models.SalesProduct
        fields = {'quantity', 'price',}

    def clean(self):
        price = self.cleaned_data.get("price")
        quantity  = self.cleaned_data.get("quantity")

        if price < 0.01:
            raise forms.ValidationError("The product price is less than 0,01€")
        if not quantity:
            raise forms.ValidationError("Enter the quantity available.")
        elif  quantity < 1:
            raise forms.ValidationError("The quantity available is negative.")

        return self.cleaned_data

# Clothing products entry form.
SalesClothingProductFormSet = modelformset_factory(model = models.SalesProduct,
    fields = ('quantity',), extra=7, min_num=1, max_num=7, )
    
# Sales entry form.
class SaleForm(ModelForm):
    class Meta:
        model  = models.Sale
        fields = ['status',]

    def clean(self):
        if self.has_changed():
            new_status = self.cleaned_data.get("status")
            old_status = self.instance.status
            last_date_updated = self.instance.date_updated

            if old_status == 20 or old_status == 30:
                d = last_date_updated + timedelta(days = 7)

                if d >= timezone.now():
                      raise forms.ValidationError("The period of 7 days for the change of the status has passed")

# Product category selection form (when importing a product)
class ProductCategoryForm(ModelForm):
    class Meta:
        model  = models.Product
        fields = ['category',]

    def clean(self):
        category= self.cleaned_data.get("category")
        if not category:
            raise forms.ValidationError("Please enter a category!")
        else:
            if category.get_descendants():
                raise forms.ValidationError(u'Please enter one of the final subcategories of the "%s" category you selected' % category.name)


# ....................................................
ProductImageFormSet = modelformset_factory(model = models.ProductImage,
fields = ('image',), extra=4, min_num=1, max_num=4, can_delete=True, validate_min=True)


class AddOfferForm(ModelForm):

    discount_rate = forms.DecimalField(required=False)
    discount_price = forms.DecimalField(required=False)

    class Meta:
        model = models.Offer
        fields = ['discount_rate', 'discount_price','is_open',
            'start_date','end_date',]
        widgets = {
            'start_date': DatePickerInput(options={
                                    "format": "DD/MM/YY",
                                    "locale": "el",},),
            'end_date': DatePickerInput(options={
                                    "format": "DD/MM/YY",
                                    "locale": "el",},),
        }

    def clean(self):
        discount_rate = self.cleaned_data.get("discount_rate")
        start_date = self.cleaned_data.get("start_date")
        end_date = self.cleaned_data.get("end_date")

        if discount_rate:
            if discount_rate < 0:
                raise forms.ValidationError("The discount price is higher than the initial one.")

        elif start_date or end_date:
                 raise forms.ValidationError("You have entered a discount date without a discount price.")

        return self.cleaned_data

# ....................................................
class AddProductForm(ModelForm):
    class Meta:
        model = models.Product
        fields = ['name',]

    def clean(self):
        name = self.cleaned_data.get("name")

        if name:
            if models.Product.objects.filter(name=name, structure = 'Stand-alone product').exists():
                raise forms.ValidationError("There is already a product with the name you entered.")
        else:
            raise forms.ValidationError("Enter the product name.")

        return self.cleaned_data
        
# Tags entry form
class AddProductTagsForm(ModelForm):
    class Meta:
        model = models.Product
        fields = ['tags']

# Clothing products add form.
class AddClothingProductForm(ModelForm):
    description = forms.CharField(required=False)
    name = forms.CharField(error_messages={'required': 'Enter the product name.'})
    material = forms.ChoiceField(error_messages={'required': 'Please select the product material.'},
        choices = models.ClothingProduct.MATERIALS)
    color = forms.ChoiceField(error_messages={'required': 'Please select the color of the product.'},
        choices = models.COLORS)

    class Meta:
        model = models.ClothingProduct
        fields = ['name', 'description','color','material',]

    def clean(self):

        name = self.cleaned_data.get("name")
        color = self.cleaned_data.get("color")
        material = self.cleaned_data.get("material")

        if 'name' in self.changed_data:
            if models.ClothingProduct.objects.filter(name=name, color = color, material = material).exists():
             raise forms.ValidationError("There is already a product with the name, color and material you entered.")
        return self.cleaned_data
        
# Footwear products add form.
class AddFootwearProductForm(ModelForm):
    description = forms.CharField(required=False)
    name = forms.CharField(error_messages={'required': 'Enter the product name.'})
    material = forms.ChoiceField(error_messages={'required': 'Please select the product material.'},
        choices = models.FootwearProduct.MATERIALS)
    color = forms.ChoiceField(error_messages={'required': 'Please select the color of the product.'},
        choices = models.COLORS)

    class Meta:
        model = models.FootwearProduct
        fields = ['name','description', 'color','material',]

    def clean(self):
        name = self.cleaned_data.get("name")
        color = self.cleaned_data.get("color")
        material = self.cleaned_data.get("material")
        if 'name' in self.changed_data:
            if models.FootwearProduct.objects.filter(name=name, color = color, material = material).exists():
                raise forms.ValidationError("There is already a product with the name, color and material you entered.")
        return self.cleaned_data

# Import bags form.
class AddBagsForm(ModelForm):
    description = forms.CharField(required=False)
    name = forms.CharField(error_messages={'required': 'Enter the product name.'})
    material = forms.ChoiceField(error_messages={'required': 'Please select the product material.'},
        choices = models.Bag.MATERIALS )
    color = forms.ChoiceField(error_messages={'required': 'Please select the color of the product.'},
        choices = models.COLORS)
    type = forms.ChoiceField(error_messages={'required': 'Please select the type of bag.'},
        choices = models.Bag.TYPES)

    class Meta:
        model = models.Bag
        fields = ['name', 'description', 'color','material','type',]

    def clean(self):
        name = self.cleaned_data.get("name")
        color = self.cleaned_data.get("color")

        if 'name' in self.changed_data:
            if models.Bag.objects.filter(name=name, color = color,).exists():
                raise forms.ValidationError("There is already a product with the name, color and material you entered.")
        return self.cleaned_data

# Import wallets form.
class AddWalletsForm(ModelForm):
    description = forms.CharField(required=False)
    name = forms.CharField(error_messages={'required': 'Enter the product name.'})
    material = forms.ChoiceField(error_messages={'required': 'Please select the product material.'},
        choices = models.Wallet.MATERIALS)
    color = forms.ChoiceField(error_messages={'required': 'Please select the color of the product.'},
        choices = models.COLORS)
    type = forms.ChoiceField(error_messages={'required': "Please select the type of wallet."},
        choices = models.Wallet.TYPES)
    type_of_closing = forms.ChoiceField(error_messages={'required': "Please select the type of wallet closure."},
        choices = models.Wallet.TYPES_OF_CLOSING)

    class Meta:
        model = models.Wallet
        fields = ['name', 'description', 'color','material','type','type_of_closing',]

    def clean(self):
        name = self.cleaned_data.get("name")
        color = self.cleaned_data.get("color")

        if 'name' in self.changed_data:
            if models.Wallet.objects.filter(name=name, color = color).exists():
                raise forms.ValidationError("There is already a product with the name, color and material you entered.")
        return self.cleaned_data

# Import watches form.
class AddWatchesForm(ModelForm):
    description = forms.CharField(required=False)
    name = forms.CharField(error_messages={'required': 'Enter the product name.'})
    display = forms.ChoiceField(error_messages={'required': "Please select the clock function."},
        choices = models.Watch.DISPLAYS)
    mechanism = forms.ChoiceField(error_messages={'required': "Please select the type of mechanism."},
        choices = models.Watch.MECHANISMS)
    band_material = forms.ChoiceField(error_messages={'required': "Please select the material of the strap."},
        choices = models.Watch.BAND_MATERIALS)
    band_color = forms.ChoiceField(error_messages={'required': "Please select the color of the strap."},
        choices = models.COLORS)
    face_color = forms.ChoiceField(error_messages={'required': "Please select the color of the dial."},
        choices = models.COLORS)
    water_resistance = forms.ChoiceField(error_messages={'required': "Please select the type of water resistance."},
        choices = models.Watch.WATER_RESISTANCE)

    class Meta:
        model = models.Watch
        fields = ['name', 'description', 'display','mechanism','band_material','band_color','face_color','water_resistance',]

    def clean(self):
        name = self.cleaned_data.get("name")
        band_color = self.cleaned_data.get('band_color')
        face_color = self.cleaned_data.get('face_color')

        if 'name' in self.changed_data:
            if models.Watch.objects.filter(name=name, band_color = band_color, face_color = face_color).exists():
                raise forms.ValidationError("There is already a watch with the name, strap color and dial color that you have entered.")
        return self.cleaned_data

# Add manufacturer.
class ManufacturerForm(ModelForm):
    name = forms.CharField(error_messages={'required': "Enter the manufacturer's name."})
    class Meta:
        model = models.Manufacturer
        fields = ['name',]

# Manage and edit the contact us form.
class ContactForm(forms.Form):
    message = forms.CharField(max_length=600, error_messages={'required': "Enter your message."})

class PeriodSelectForm(forms.Form):
    MONTHS =  ((1, "Jan"), (2, "Feb"), (3, "Mar"), (4, "Apr"), (5, "May"),
         (6, "Jun"), (7, "Jul"), (8, "Aug"), (9, "Sep"),(10, "Oct"), 
         (11, "Nov"), (12, "Dec"))

    YEARS = ((2019, "2019"), (2020, "2020"), (2021, "2021"))

    month = forms.TypedChoiceField(choices=MONTHS, coerce=int, required=False)

    year = forms.TypedChoiceField(choices=YEARS, coerce=int, required=False)

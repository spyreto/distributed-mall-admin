from main import forms, models
import django_filters
from django import forms as django_forms
from django.db import models as django_models
from django_filters.widgets import BooleanWidget

from bootstrap_datepicker_plus import DateTimePickerInput, DatePickerInput

# Filter for general type products.
class ProductsFilter(django_filters.FilterSet):
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.Product
        fields = ['name','manufacturer','id']

# Filter for clothing products.
class ClothingProductsFilter(django_filters.FilterSet):
    manufacturer__name = django_filters.CharFilter(lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.ClothingProduct
        fields = {
            'id': ['exact'],
            'color':['exact'],
            'material':['exact'],
        }

# Filter for footwear products.
class FootwearProductsFilter(django_filters.FilterSet):
    manufacturer__name = django_filters.CharFilter(lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.FootwearProduct
        fields = {
            'id': ['exact'],
            'color':['exact'],
            'material':['exact'],
        }

# Filter class for bags.
class BagsFilter(django_filters.FilterSet):
    manufacturer__name = django_filters.CharFilter(lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.Bag
        fields = {
            'id': ['exact'],
            'color':['exact'],
            'material':['exact'],
            'type':['exact'],
        }

# Filter class for wallets.
class WalletsFilter(django_filters.FilterSet):
    manufacturer__name = django_filters.CharFilter(lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.Wallet
        fields = {
            'id': ['exact'],
            'color':['exact'],
            'material':['exact'],
            'type':['exact'],
        }
        
# Filter class for watches.
class WatchesFilter(django_filters.FilterSet):
    manufacturer__name = django_filters.CharFilter(lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = models.Watch
        fields = {
            'id': ['exact'],
            'display': ['exact'],
            'mechanism':['exact'],
            'band_material':['exact'],
            'band_color':['exact'],
        }

class DateInput(django_forms.DateInput):
    input_type = 'date'

# Filter class for sales.
class SaleFilter(django_filters.FilterSet):
    class Meta:
        model = models.Sale
        fields = {
            'product__name': ['icontains'],
            'id': ['exact'],
            'customer__user__email': ['icontains'],
            'status': ['exact'],
            'paid_with_money': ['exact'],
            'date_added': ['gte', 'lte'],
        }

        filter_overrides = {
                django_models.DateTimeField: {
                    'filter_class': django_filters.DateTimeFilter,
                    'extra': lambda f:{
                        'widget': DateTimePickerInput(options={
                                                "format": "DD/MM/YY HH:mm",
                                                "locale": "el",},),

            },},}
            
# Filter for Offers.
class OffersFilter(django_filters.FilterSet):
    class Meta:
        model = models.Offer
        fields = {
            'product__name': ['icontains'],
            'id': ['exact'],
            'is_open': ['exact'],
            'start_date': ['gte', 'lte'],
            'end_date': ['gte', 'lte'],
        }

        filter_overrides = {
                django_models.DateField: {
                    'filter_class': django_filters.DateFilter,
                    'extra': lambda f:{
                        'widget': DatePickerInput(options={
                                                "format": "DD/MM/YY",
                                                "locale": "el",},),

            },},}

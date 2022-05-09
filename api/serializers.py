from rest_framework import serializers
from rest_framework_recursive.fields import RecursiveField
from django.apps import apps

from rest_framework.response import Response
from django.contrib.auth.hashers import make_password


from phonenumber_field.serializerfields import PhoneNumberField

from taggit_serializer.serializers import (TagListSerializerField, TaggitSerializer)

import re

# Serializer
class ProductsCategoriesSerializer(serializers.ModelSerializer):

    name = serializers.CharField(required=False)
    children = serializers.ListSerializer(child=RecursiveField())

    class Meta:
        model = apps.get_model('main','ProductCategory')
        fields = ("id", "name", "children",)

    def validate(self, data):
        name = data.get('name', None)
        children = data.get('children', None)

        if not name and not children:
            raise serializers.ValidationError("Enter subcategory for association.")
        return data

# Serializer
class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Location')
        fields = ['geolocation']

# Serializer
class CompanySerializer(serializers.ModelSerializer):
    location = LocationSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','Company')
        fields = ['name', 'location', 'id']

# Serializer
class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','ProductImage')
        fields = ['image', 'thumbnail']

# Serializer
class ManufacturerSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Manufacturer')
        fields = ['name', 'id']

# Product category serializer to display the category type (eg Clothing)
class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','ProductCategory')
        fields = ['id','type']

# Serializer
class ProductTagSerializer(TaggitSerializer, serializers.ModelSerializer):
    tags = TagListSerializerField()
    class Meta:
        model = apps.get_model('main','Product')

# Serializer
class ProductSerializer(TaggitSerializer, serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Product')
        exclude = ['manufacturer', 'category', 'id'
            ,'date_updated', 'structure', 'active', 'slug', 'parent']

# Serializer
class ClothingProductSerializer(serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    product_ptr = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','ClothingProduct')
        fields = ['color','get_color_display','material',
            'get_material_display','product_ptr','manufacturer',
            'size', 'get_size_display']

# Serializer
class FootwearProductSerializer(serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    product_ptr = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','FootwearProduct')
        fields = ['color','get_color_display','material',
            'get_material_display','product_ptr','manufacturer',
            'size', 'get_size_display']

# Serializer
class BagSerializer(serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    product_ptr = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','Bag')
        fields = ['type','get_type_display','color','get_color_display','material',
            'get_material_display','product_ptr','manufacturer']

# Serializer
class WalletSerializer(serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    product_ptr = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','Wallet')
        fields = ['type','get_type_display',
            'color','get_color_display',
            'material', 'get_material_display',
            'type_of_closing', 'get_type_of_closing_display',
            'product_ptr','manufacturer']

# Serializer
class WatchSerializer(serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    product_ptr = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','Watch')
        fields = ['display','get_display_display',
            'mechanism','get_mechanism_display',
            'band_material', 'get_band_material_display',
            'band_color', 'get_band_color_display',
            'face_color','get_face_color_display',
            'water_resistance', 'get_water_resistance_display',
            'product_ptr','manufacturer']


# Serializer to filter bids so that only active ones are displayed.
class FilteredOffersSerializer(serializers.ListSerializer):
    def to_representation(self, data):
        data = data.filter(is_open=True)
        return super(FilteredOffersSerializer, self).to_representation(data)

# Offers Serializer.
class OfferSerializer(serializers.ModelSerializer):
    class Meta:
        list_serializer_class = FilteredOffersSerializer
        model = apps.get_model('main','Offer')
        fields= ['discount_rate', 'discount_price',]

# Serializer
class SalesProductSerializer(serializers.ModelSerializer):
    company = CompanySerializer(read_only=True)
    offer = OfferSerializer(many=True, read_only=True)

    class Meta:
        model = apps.get_model('main','SalesProduct')
        exclude = ['date_updated', 'id']

# Serializer
class SearchProductsSerializer(TaggitSerializer, serializers.ModelSerializer):
    manufacturer = ManufacturerSerializer(read_only=True)
    category = CategorySerializer(read_only=True)
    image = ImageSerializer(many=True, read_only=True)
    salesproduct_set = SalesProductSerializer(many=True, read_only=True)

    class Meta:
        model = apps.get_model('main','Product')
        exclude = ['description','date_updated', 'structure', 'active', 'slug', 'parent']


# Serializer
class FootwearProductSizeSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','SalesProduct')

    def to_representation(self, instance):
        return {
            'quantity': instance.quantity,
            'size': instance.product.footwearproduct.size,
            'label': instance.product.footwearproduct.get_size_display(),
        }

# Serializer
class ClothingProductSizeSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','SalesProduct')

    def to_representation(self, instance):
        return {
            'quantity': instance.quantity,
            'size': instance.product.clothingproduct.size,
            'label': instance.product.clothingproduct.get_size_display(),
        }

class SaleSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Sale')
        fields = (
            'quantity', 'paid_with_money','company'
        )


class HistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Sale')

    def to_representation(self, instance):
        ProductImages = apps.get_model('main','ProductImage')
        Products = apps.get_model('main','Product')

        if (instance.product.structure == 'child'):
            product = Products.objects.get(pk = instance.product.parent.id)
        else:
            product =  instance.product

        image = ProductImages.objects.filter(product = product).first()

        company = CompanySerializer(instance.company)
        return {
            'company': company.data,
            'product': {
                'id': product.pk,
                'name': product.name,
                'image': image.image.url,
                'thumbnail': image.thumbnail.url
            },
            'paid_with_money': instance.paid_with_money,
            'status': instance.status,
            'quantity': instance.quantity,
            'selling_price': instance.selling_price,
            'date_added': instance.date_added.date(),
        }

class FavoritesSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Favorite')

    def to_representation(self, instance):
        ProductImages= apps.get_model('main','ProductImage')
        image = ProductImages.objects.filter(product = instance.product.pk).first()

        return {
            'id': instance.product.pk,
            'name': instance.product.name,
            'image': image.image.url,
            'thumbnail': image.thumbnail.url
        }

# User Serializer.
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','User')
        fields = ('id','first_name', 'last_name', 'email')


class CustomerSerializer(serializers.ModelSerializer):
    phone_number = PhoneNumberField()
    user = UserSerializer(read_only = True)

    class Meta:
        model = apps.get_model('main','Customer')
        fields = ('user' ,'gender', 'birth_date', 'phone_number', 'device_id', 'orange_points')


class RegistrationSerializer(serializers.ModelSerializer):
    customer = CustomerSerializer()

    class Meta:
        model = apps.get_model('main','User')
        fields = ('email', 'password', 'first_name', 'last_name' , 'customer', )

    def create(self, validated_data):
        customer_data = validated_data.pop('customer', None)
        email = validated_data['email']
        password = make_password(validated_data.pop('password'))


        User = apps.get_model('main','User')
        Customer = apps.get_model('main','Customer')

        if apps.get_model('main','User').objects.filter(email=email).exists():
            error = {'email': u'Email %s is already in use.' % email}
            raise serializers.ValidationError(error)

        if apps.get_model('main','Customer').objects.filter(phone_number=customer_data['phone_number']).exists():
            error = {'error': u'Phone %s is already in use.' % customer_data['phone_number']}
            raise serializers.ValidationError(error)

        if len( password )<8:
            error = {"error": "The new password must contain at least 8 characters."}
            raise serializers.ValidationError(error)
        elif not re.search("[A-Za-z]", password):
            error = {"error": "The new code consists of numbers only"}
            raise serializers.ValidationError(error)

        user = User.objects.create(is_customer = True, password = password, **validated_data)
        Customer.objects.create(user=user, **customer_data)

        return user


# User information update serializer.
class UserUpdateSerializer(serializers.ModelSerializer):
    customer = CustomerSerializer()

    class Meta:
        model = apps.get_model('main','User')
        fields = ('email', 'first_name', 'last_name' , 'customer', )
        extra_kwargs = {
            'email':
                {"error_messages":
                    {"blank": "Email is required.",
                    "required": "Email is required.",
            }},
        }


    def update(self, instance, validated_data):
        customer_data = validated_data.pop('customer', None)
        email = validated_data.pop('email', None)
        first_name = validated_data.pop('first_name', None)
        last_name = validated_data.pop('last_name', None)

        instance.first_name = first_name
        instance.last_name = last_name
        instance.customer.birth_date = customer_data['birth_date']
        if (instance.customer.phone_number != customer_data['phone_number']):
            if apps.get_model('main','Customer').objects.exclude(pk = instance.pk).filter(phone_number=customer_data['phone_number']).exists():
                error = {'phone_number': u'Phone %s is already in use.' % customer_data['phone_number']}
                raise serializers.ValidationError(error)

            instance.customer.phone_number = customer_data['phone_number']
        instance.customer.save()

        return super().update(instance, validated_data)

class ChangePasswordSerializer(serializers.Serializer):
    model = apps.get_model('main','User')

    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

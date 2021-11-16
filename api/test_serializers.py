from rest_framework import serializers
from rest_framework_recursive.fields import RecursiveField
from django.apps import apps

from taggit_serializer.serializers import (TagListSerializerField, TaggitSerializer)


class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','Location')
        fields = ['geolocation']


class ClothingProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('main','ClothingProduct')
        fields = ['size',]



class ProductSerializer(serializers.ModelSerializer):
    clothingproduct = ClothingProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','Product')
        fields = [ 'name','parent', 'structure', 'clothingproduct']



# Serializer
class SalesProductSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)
    class Meta:
        model = apps.get_model('main','SalesProduct')
        fields = ['price' , 'quantity', 'product']

class Filter(serializers.ListSerializer):
    def to_representation(self, data):
        print(data)
        data = data.filter(sales_product__product__structure="child")
        return super(Filter, self).to_representation(data)

class CompanySerializer(serializers.HyperlinkedModelSerializer):

    sales_product = SalesProductSerializer(many=True, read_only=True)

    class Meta:
        model = apps.get_model('main','Company')
        fields = ['sales_product']

    def to_representation(self, instance):
        output = {}
        ret = super().to_representation(instance)

        for i in ret['sales_product']:
            i['parent'] = 5000000
        return ret


# Serializer

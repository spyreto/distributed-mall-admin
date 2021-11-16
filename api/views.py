from django.http import HttpResponse, JsonResponse
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token

from rest_framework.generics import UpdateAPIView

from api import serializers
from api import test_serializers

from rest_framework.decorators import (
    api_view,
    permission_classes,
)

from rest_framework.response import Response
from rest_framework.views import APIView

from django.db.models import Count, Q

from django.apps import apps

from slugify import slugify

import re

class AuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                       context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']

        #Εξαγωγή ιστορικού αγορών χρήστη
        Sales = apps.get_model('main','Sale')
        sales_qs = Sales.objects.filter(customer = user.pk)
        history_serializer = serializers.HistorySerializer(sales_qs, many = True)

        #Εξαγωγή αγαπημένων προϊόντων χρήστη
        Favorite = apps.get_model('main','Favorite')
        favorites_qs = Favorite.objects.filter(customer = user.pk)
        favorites_serializer = serializers.FavoritesSerializer(favorites_qs, many = True)

        #Εξαγωγή πληροφοριών χρήστη
        Customers = apps.get_model('main','Customer')
        customer_qs = Customers.objects.filter(user_id = user.pk)
        customer_serializer = serializers.CustomerSerializer(customer_qs, many = True)

        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'history': history_serializer.data,
            'user_info': customer_serializer.data,
            'email': user.email,
            'favorites': favorites_serializer.data
        })

class GetUserInfo(APIView):
    permission_classes = (IsAuthenticated,)
    def get(self, request, *args, **kwargs):
        user = request.user

        #Εξαγωγή ιστορικού αγορών χρήστη
        Sales = apps.get_model('main','Sale')
        sales_qs = Sales.objects.filter(customer = user.pk)
        history_serializer = serializers.HistorySerializer(sales_qs, many = True)

        #Εξαγωγή αγαπημένων προϊόντων χρήστη
        Favorite = apps.get_model('main','Favorite')
        favorites_qs = Favorite.objects.filter(customer = user.pk)
        favorites_serializer = serializers.FavoritesSerializer(favorites_qs, many = True)

        #Εξαγωγή πληροφοριών χρήστη
        Customers = apps.get_model('main','Customer')
        customer_qs = Customers.objects.filter(user_id = user.pk)
        customer_serializer = serializers.CustomerSerializer(customer_qs, many = True)

        token, created = Token.objects.get_or_create(user=user)

        return Response({
            'history': history_serializer.data,
            'user_info': customer_serializer.data,
            'favorites': favorites_serializer.data
        })


class RegistrationView(APIView):
    def post(self, request, *args, **kwargs):
        serializer = serializers.RegistrationSerializer(data=request.data)
        data = {}

        if serializer.is_valid():
            user = serializer.save()
            Customers = apps.get_model('main','Customer')
            customer_qs = Customers.objects.filter(user_id = user.pk)
            customer_serializer = serializers.CustomerSerializer(customer_qs, many = True)
            token, created = Token.objects.get_or_create(user=user)

            data['response'] = 'Η εγγραφή σας ολοκληρώθηκε επιτυχώς!'
            data['token'] = token.key
            data['user_info'] = customer_serializer.data
            return Response(data)
        else:
            data = serializer.errors
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



class ChangePasswordView(UpdateAPIView):
        serializer_class = serializers.ChangePasswordSerializer
        model = apps.get_model('main','User')
        permission_classes = (IsAuthenticated,)

        def get_object(self, queryset=None):
            obj = self.request.user
            return obj

        def update(self, request, *args, **kwargs):
            self.object = self.get_object()
            serializer = self.get_serializer(data=request.data)

            if serializer.is_valid():
                old_password = serializer.data.get("old_password")
                new_password = serializer.data.get("new_password")

                # Check old password
                if not self.object.check_password(old_password):
                    return Response({"message": "Λάθος προηγούμενος κωδικός!"}, status=status.HTTP_400_BAD_REQUEST)
                # set_password also hashes the password that the user will get

                if len(new_password)<8:
                    return Response({"message": "O νέος κωδικός πρέπει να περιέχει τουλάχιστον 8 χαρακτήρες."}, status=status.HTTP_400_BAD_REQUEST)
                if not re.search("[A-Za-z]", new_password):
                    return Response({"message": "O νέος κωδικός αποτελείται μόνο απο αριθμούς"}, status=status.HTTP_400_BAD_REQUEST)

                self.object.set_password(new_password)
                self.object.save()
                response = {
                    'status': 'success',
                    'code': status.HTTP_200_OK,
                    'message': 'Ο κωδικός άλλαξε επιτυχώς!',
                    'data': []
                }
                return Response(response)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ChangeInfo(UpdateAPIView):
    Customers = apps.get_model('main','User')
    queryset =  Customers.objects.all()
    serializer_class =  serializers.UserUpdateSerializer
    permission_classes = ( IsAuthenticated,)

class RemoveFavoriteView(APIView):
    def post(self, request, pk, *args, **kwargs):
        permission_classes = ( IsAuthenticated,)
        Favorite = apps.get_model('main','Favorite')
        favorite = Favorite.objects.filter(product = pk, customer = request.user.customer)
        favorite.delete()
        return Response(status=200)

class AddFavoriteView(APIView):
    def get(self, request, pk, *args, **kwargs):
        permission_classes = ( IsAuthenticated,)
        Favorite = apps.get_model('main','Favorite')
        Product = apps.get_model('main','Product')
        product = Product.objects.get(id = pk)
        favorite = Favorite.objects.create(product = product, customer = request.user.customer)
        favorite.save()
        serializer = serializers.FavoritesSerializer(favorite , many = True)
        return Response(status=200)


class ProductsCategoriesView(APIView):
    def get(self, request, *args, **kwargs):
        ProductsCategories = apps.get_model('main','ProductCategory')
        qs = ProductsCategories.objects.root_nodes()
        serializer = serializers.ProductsCategoriesSerializer(qs , many = True)
        return Response(serializer.data)

class SearchProductsView(APIView):
    def get(self, request, keyword, *args, **kwargs):
        keyword_slug = slugify(keyword)
        SearchProducts = apps.get_model('main','Product')
        qs = SearchProducts.objects.filter( Q(structure = 'parent') | Q(structure = 'standalone'),

            Q(slug__icontains = keyword_slug) |

            Q(tags__name__icontains = keyword_slug) |

            Q(category__slug__icontains = keyword_slug) |

            Q(manufacturer__slug__icontains = keyword_slug),
            salesproduct__quantity__gt = 0,
        ).distinct('id')
        serializer = serializers.SearchProductsSerializer(qs , many = True)
        return Response(serializer.data)

class ProductView(APIView):
    def get(self, request, pk, *args, **kwargs):
        Products = apps.get_model('main','Product')
        product = Products.objects.filter(id = pk)
        serializer = serializers.SearchProductsSerializer(product, many = True)
        return Response(serializer.data)

class ProductsDetailsView(APIView):
    def get(self, request, pk, category_type , *args, **kwargs):
        if category_type == 10:
            ProductDetails = apps.get_model('main','ClothingProduct')
            qs = ProductDetails.objects.filter(id = pk)
            serializer = serializers.ClothingProductSerializer(qs , many = True)
        elif category_type == 20:
            ProductDetails = apps.get_model('main','FootwearProduct')
            qs = ProductDetails.objects.filter(id = pk)
            serializer = serializers.FootwearProductSerializer(qs , many = True)
        elif category_type == 30:
            ProductDetails = apps.get_model('main','Bag')
            qs = ProductDetails.objects.filter(id = pk)
            serializer = serializers.BagSerializer(qs , many = True)
        elif category_type == 35:
            ProductDetails = apps.get_model('main','Wallet')
            qs = ProductDetails.objects.filter(id = pk)
            serializer = serializers.WalletSerializer(qs , many = True)
        elif category_type == 40:
            ProductDetails = apps.get_model('main','Watch')
            qs = ProductDetails.objects.filter(id = pk)
            serializer = serializers.WatchSerializer(qs , many = True)

        return Response(serializer.data)


class OffersView(APIView):
    def get(self, request, *args, **kwargs):
        ProductCategory = apps.get_model('main','Offer')
        qs = ProductCategory.objects.all()
        serializer = serializers.OfferSerializer(qs , many = True)

        return Response(serializer.data)

class AvailableSizes(APIView):
    def get(self, request, product_id, category_type, seller_id,*args, **kwargs):
        products = apps.get_model('main','SalesProduct')
        qs = products.objects.filter( product__structure = 'child',
            product__parent =  product_id, company = seller_id, quantity__gt = 0)
        if category_type == 10:
            serializer = serializers.ClothingProductSizeSerializer(qs , many = True)
        elif category_type == 20:
            serializer = serializers.FootwearProductSizeSerializer(qs , many = True)
        return Response(serializer.data)


@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
def product_reservation(request, product_id,filters, *args, **kwargs):
    serializer = serializers.SaleSerializer(data=request.data)
    if serializer.is_valid():
        products = apps.get_model('main','Product')
        offers = apps.get_model('main','Offer')
        sales_product = apps.get_model('main','SalesProduct')

        customer = request.user
        product = products.objects.get(id = product_id)

        company=serializer.validated_data.get('company')
        paid_with_money=serializer.validated_data.get('paid_with_money')
        quantity=serializer.validated_data.get('quantity')

        selling_price = 0

        if (product.category.type ==10):
            products = apps.get_model('main','ClothingProduct')
            product = products.objects.get(parent_id = product_id, size = filters)
        elif (product.category.type ==20):
            products = apps.get_model('main','FootwearProduct')
            product = products.objects.get(parent_id = product_id, size = filters)

        sale = sales_product.objects.get(company=company, product = product)

        if offers.objects.filter(company=company, product = product, is_open=True, has_expired=False).exists():
            offer = offers.objects.get(company=company, product = product, is_open=True, has_expired=False)
            selling_price = offer.discount_price
        else:
            selling_price = sale.price

        #Έλεγχος διατιθέμενης ποσότητας
        if (sale.quantity < quantity):
            return Response({"message":'Δεν υπάρχει επαρκής ποσότητα για το προϊόν που επιλέξατε...'}, status.HTTP_400_BAD_REQUEST)

        #Έλεγχος σε περίπτωση πληρωμής με πόντους, για το αν οι πόντοι του χρήστη επαρκούν
        if paid_with_money:
            serializer.save(customer=request.user.customer, product = product, selling_price=selling_price)
        else:
            if request.user.customer.orange_points < 200*selling_price*quantity:
                return Response({"message":'Οι orange points σου δεν επαρκούν για την αγορά!'},
                 status=status.HTTP_400_BAD_REQUEST)
            else:
                serializer.save(customer=request.user.customer, product = product, selling_price=selling_price)

        return Response(status.HTTP_201_CREATED)
    else:
        return Response({"message":'Προέκυψε κάποιο σφάλμα, παρακαλώ προσπαθήστε ξανά...'}, status.HTTP_400_BAD_REQUEST)

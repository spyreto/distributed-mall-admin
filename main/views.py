from django.shortcuts import render, redirect, HttpResponseRedirect, reverse
from django.urls import reverse_lazy
from django.views.generic.edit import (
    FormView,
    DeleteView,
)
from django.views.generic import ListView, DetailView, TemplateView

from main import forms, models, mixins, widgets, filters
from main.decorators import seller_has_company
from main.filters import ProductsFilter, SaleFilter

from django.forms import ModelForm

from django.contrib import messages
from django.contrib.auth import login,logout, authenticate
from django.contrib.auth.views import PasswordChangeView
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin

from django import forms as django_forms
from django_filters.views import FilterView

from django.core.mail import send_mail
from django.conf import settings

from django.db.models import Count, Q, Value
from django.db.models.functions import Replace

import json

import logging

import calendar
import datetime

from django.db.models import F, Sum
from django.db.models.functions import ExtractMonth, ExtractDay, ExtractWeekDay
from django.utils import timezone
from django.db import models as django_models

from django.forms import modelformset_factory

from slugify import slugify

logger = logging.getLogger(__name__)


# Home page.
@login_required
@seller_has_company
def home(request):
    current_date = timezone.now()
    enddate = datetime.date.today()
    startdate = enddate + datetime.timedelta(days=-7)

    # Queryset of weekly revenue.
    incomes_per_day_dataset = models.Sale.objects.filter(company = request.user.seller.owns_company,
        date_updated__range=[startdate, enddate], paid_with_money = True,
        status = 20) \
        .annotate(week_day=ExtractWeekDay('date_updated'),) \
        .values('week_day') \
        .annotate(total = Sum(
                    F('quantity') *
                    F('selling_price'),
                    output_field=django_models.FloatField()
                )) \
        .order_by('week_day')


    print(incomes_per_day_dataset)
    daysIncomeIndexes = [x["week_day"] for x in incomes_per_day_dataset]
    daysIncomeValues = [x["total"] for x in incomes_per_day_dataset]

    week_sales = models.Sale.objects.filter(company = request.user.seller.owns_company, date_updated__range=[startdate, enddate])

    reserve_processing = models.Sale.objects.filter(company = request.user.seller.owns_company, status=10).count()

    lack_of_products = models.SalesProduct.objects.filter(Q(company = request.user.seller.owns_company),
        Q(product__structure = 'parent') | Q(product__structure = 'standalone'), Q(quantity=0)).count()

    ended_offers = models.Offer.objects.filter(company = request.user.seller.owns_company, end_date=enddate).count()

    active_offers = models.Offer.objects.filter(company = request.user.seller.owns_company, is_open=True).count()

    args={}
    args['daysIncomeIndexes'] = json.dumps(daysIncomeIndexes)
    args['daysIncomeValues'] = json.dumps(daysIncomeValues)
    args['week_sales'] = week_sales
    args['reserve_processing'] = reserve_processing
    args['lack_of_products'] = lack_of_products
    args['ended_offers'] = ended_offers
    args['active_offers'] = active_offers

    return render(request, 'home.html', args)

# Registration form management CBV (Class-based View).
class SellerSignupView(FormView):
    template_name = "signup.html"
    form_class = forms.SellerCreationForm

    def get_success_url(self):
        redirect_to = self.request.GET.get("next", "/")
        return redirect_to

    def form_valid(self, form):
        response = super().form_valid(form)
        form.save()

        email = form.cleaned_data.get("email")
        raw_password = form.cleaned_data.get("password1")

        logger.info(
            "New signup for email=%s through SignupView", email
        )

        user = authenticate(email=email, password=raw_password)
        login(self.request, user)

        form.send_mail()

        messages.success(
            self.request, "Your registration was completed successfully"
        )

        return response

# User logout function.
def logoutView(request):
    logout(request)
    return redirect('login')



# Management and editin FBV (Function-based View) of the account management form.
@login_required
def account_manage(request):
    company = models.Company.objects.filter(owner=request.user.seller).first()

    company_location = models.CompanyLocation.objects.filter(company=company).first()

    # Forms for managing user data for each model (seller, company and location models)
    seller_form = forms.AccountManagementSellerForm(
        request.POST or None, instance=request.user.seller.user)

    company_form = forms.AccountManagementCompanyForm(
            request.POST or None, instance= company )

    company_location_form = forms.AccountManagementLocationForm(
            request.POST or None, instance=company_location)


    if request.method == 'POST':
        if all([seller_form.is_valid(), company_form.is_valid(), company_location_form.is_valid()]):
            company = company_form.save(commit=False)
            company.owner = request.user.seller
            company.save()
            company_location = company_location_form.save(commit=False)
            company_location.company = company
            company_location.save()

            messages.success(
                request, "Your data change completed successfully"
            )

            return redirect('home')

    args = {}
    args['seller_form'] = seller_form
    args['company_form'] = company_form
    args['company_location_form'] = company_location_form

    return render(request, 'account_manage.html', args)

# Password change form.
class PasswordChangeView(PasswordChangeView):
    template_name = "password_change.html"

    def get_success_url(self):
        redirect_to = self.request.GET.get("next", "/")
        return redirect_to

# FBV for "About us" form.
@login_required
def contact_us_view(request):
    form = forms.ContactForm(request.POST or None)
    email = request.user.email
    fname = request.user.first_name
    lname = request.user.last_name
    args = {}
    args['fname'] = fname
    args['lname'] = lname
    args['email'] = email
    args['form'] = form

    if request.method == 'POST':
        if form.is_valid():
            message = request.POST.get('message')
            subject = 'Contact From Received'
            from_email = settings.DEFAULT_FROM_EMAIL
            to_email = [settings.DEFAULT_FROM_EMAIL]

            contact_message = "{0}, from {1} {2} with email {3}".format(message,
            fname, lname, from_email)
            send_mail(subject, contact_message, from_email, to_email, fail_silently = True)
            return HttpResponseRedirect(reverse('home'))

    return render(request, "contact_form.html", args)

# View the list of products available to the seller.
class ProductListView(mixins.UserHasCompanyMixin, ListView):
    template_name = "main/product_list.html"
    model = models.SalesProduct

    def get_queryset(self):
        # Only products with 'parent' and 'standalone' structure returned. 
        # The 'parent' structure is the main display of a product
        # with subcategories such as size.
        return self.model.objects.filter(Q(company=self.request.user.seller.owns_company),
            Q(product__structure = 'parent') | Q(product__structure = 'standalone'))


# Function to display results of the main search bar.
@login_required
@seller_has_company
def search_results(request, keyword):
    args = {}
    if keyword.isnumeric():
        results = models.Product.objects.filter( Q(structure = 'parent') | Q(structure = 'standalone'),
            Q(id = keyword) |

            Q(slug__icontains = keyword) |

            Q(manufacturer__slug__icontains = keyword)
        ).distinct('id')
    else:
        keyword_slug = slugify(keyword)
        results = models.Product.objects.filter( Q(structure = 'parent') | Q(structure = 'standalone'),

            Q(slug__icontains = keyword_slug) |

            Q(tags__name__icontains = keyword_slug) |

            Q(category__slug__icontains = keyword_slug) |

            Q(manufacturer__slug__icontains = keyword_slug)
        ).distinct('id')


    args['results'] = results
    return render(request, 'main/search_results.html', args)

# FBV for processing seller's product details.
@login_required
@seller_has_company
def product_manage(request, pk, category_type):
    args = {}
    template = ""
    company = request.user.seller.owns_company
    sales_product = models.SalesProduct.objects.filter(product_id = pk, company = company).first()


    offers_product = models.Offer.objects.filter(offer__product_id = pk,
        offer__company = company, is_open = True).first()

    sales_product_form = forms.SalesProductForm(request.POST or None, instance=sales_product)
    offer_form = forms.AddOfferForm(request.POST or None, instance=offers_product)

    # Each general product category (such as clothing, mobile phones)
    # requires different management to process its metadata.
    if category_type == 0:
        product_template = "product_manage.html"

    # Clothing and footwear products
    elif category_type == 10:
        product = models.ClothingProduct.objects.get(id = pk)

        args['sizes'] = ['XXS','XS','S','M', 'L', 'XL', 'XXL']

        product_formset = forms.SalesClothingProductFormSet(request.POST or None,
            queryset= models.SalesProduct.objects.filter(company=request.user.seller.owns_company,
            product__parent = product))

        args['product_formset']  =  product_formset
        product_template = "clothing_product.html"

    # Footwear products
    elif category_type == 20:
        product = models.FootwearProduct.objects.get(id = pk)

        # Differentiate the size of the size chart for each gender.
        if 'Men' in product.category.name:
            args['sizes'] = [39, 39.5, 40, 40.5, 41, 41.5, 42, 42.5, 43, 43.5, 44, 44.5,
                45, 45.5, 46, 46.5, 47, 47.5, 48, 48.5, 49]
        elif 'Women' in product.category.name:
            args['sizes'] =  [35, 35.5, 36, 36.5, 37, 37.5, 38, 38.5, 39, 39.5, 40, 40.5,
                41, 41.5, 42, 42.5, 43]
        else:
            args['sizes'] = [17, 17.5, 18, 18.5, 19, 19.5, 20, 20.5, 21, 21.5, 22, 22.5,
                23, 23.5, 24, 24.5, 25, 25.5, 26.5, 26, 27, 27.5, 28, 28.5, 29, 29.5, 30,
                30.5, 31, 31.5, 32, 32.5, 33, 33.5, 34, 34.5, 35, 35.5, 36, 36.5, 37, 37.5,
                38, 38.5, 39, 39.5, 40]

        # Footwear product sale entry form.ς.
        # It is created in views.py due to the variable number of forms (per size).
        SalesFootwearProductFormSet = modelformset_factory(model = models.SalesProduct,
            fields = ('quantity',), min_num=1, max_num = (len(args['sizes'])), extra = (len(args['sizes'])))

        product_formset = SalesFootwearProductFormSet(request.POST or None,
            queryset= models.SalesProduct.objects.filter(company=request.user.seller.owns_company,
            product__parent = product))

        args['product_formset']  =  product_formset
        product_template = "footwear_product.html"

    # Bags
    elif category_type == 30:
        product = models.Bag.objects.get(id = pk)
        product_template = "bags.html"

    # Wallets
    elif category_type == 35:
        product = models.Wallet.objects.get(id = pk)
        product_template = "wallets.html"

    # Watches
    elif category_type == 40:
        product = models.Watch.objects.get(id = pk)
        product_template = "watches.html"


    args['product'] = product
    args['offer_form']  =  offer_form
    args['sales_product_form']  =  sales_product_form
    template = "main/product_manage/" + product_template

    if request.method == 'POST':
        if  (sales_product_form.is_valid() and offer_form.is_valid()):
            if product.structure == 'standalone':
                sales_product = sales_product_form.save(commit=False)
                sales_product.company = company
                sales_product.product_id = pk
                sales_product.save()

            # Clothing products
            elif category_type == 10:
                if product_formset.is_valid():
                    sales_product = sales_product_form.save(commit=False)
                    sales_product.company = company
                    sales_product.product_id = pk
                    sales_product.save()

                    # Create product size items.
                    for i in range(len(product_formset)):
                        # Create objects by size.
                        clothing_product, created  = models.ClothingProduct.objects.get_or_create(parent = product,
                            structure = 'child',  size = 10*i + 10, category = product.category, material = product.material
                            ,color = product.color, manufacturer = product.manufacturer, name = product.name)

                        sales_clothing_product = product_formset[i].save(commit=False)
                        sales_clothing_product.company = company
                        sales_clothing_product.product = clothing_product
                        sales_clothing_product.price = sales_product.price
                        sales_clothing_product.description = ''
                        sales_clothing_product.save()

            elif category_type == 20:
                if product_formset.is_valid():
                    sales_product = sales_product_form.save(commit=False)
                    sales_product.company = company
                    sales_product.product_id = pk
                    sales_product.save()

                    # Create product size items.
                    for i in range(len(product_formset)):
                        # Create objects by size.
                        Footwear_product, created  = models.FootwearProduct.objects.get_or_create(parent = product,
                            structure = 'child',  size = args['sizes'][i], category = product.category, material = product.material
                            ,color = product.color, manufacturer = product.manufacturer, name = product.name)

                        sales_footwear_product = product_formset[i].save(commit=False)
                        sales_footwear_product.company = company
                        sales_footwear_product.product = Footwear_product
                        sales_footwear_product.price = sales_product.price
                        sales_footwear_product.description = ''
                        sales_footwear_product.save()


            # Save offer.
            if offer_form.cleaned_data.get("discount_rate"):
                if  offers_product is None:
                    if offer_form.cleaned_data.get("is_open"):
                        offer = offer_form.save(commit=False)
                        offer.offer = sales_product
                        offer.product = sales_product.product
                        offer.company = sales_product.company
                        offer.save()
                else:
                    offer = offer_form.save()

            messages.success(
                request, "The processing of the product %s was completed successfully"
                % product.name
            )

            return redirect('product_list')

    return render(request, template, args)

# Deleting a product from a seller's list.
class ProductDeleteView(mixins.UserHasCompanyMixin, DeleteView):
    model = models.SalesProduct
    success_url = reverse_lazy("product_list")
    template_name = "main/product_delete.html"
    success_message = "The deletion of the product %s was completed successfully"

    def get_queryset(self):
        return self.model.objects.filter(company=self.request.user.seller.owns_company)

    def delete(self, request, *args, **kwargs):
        obj = self.get_object()
        # Delete all representations of the object (product).
        if obj.product.structure == 'parent':
            models.SalesProduct.objects.filter(product__parent=obj.product).delete()
        messages.info(self.request, self.success_message % obj.product.name)
        return super(ProductDeleteView, self).delete(request, *args, **kwargs)

# FBV for selecting a category (product filtering) when adding a product.
@login_required
@seller_has_company
def select_product_category(request):
    initial={'category_id': request.session.get('category', None)}
    form = forms.ProductCategoryForm(request.POST or None, initial=initial)
    if request.method == 'POST':
        if form.is_valid():
            category = form.cleaned_data['category']
            return redirect('select_product', category_id = category.id)

    return render(request, 'main/select_product_category.html', {'form': form})


# FBV for selecting already registered products.
@login_required
@seller_has_company
def select_product(request, category_id):
    category = models.ProductCategory.objects.get(id = category_id)
    request.session['category_id'] = category_id
    if category.type == 0:
        products = models.Product.objects.filter(category = category)
        filter  = filters.ProductsFilter(request.GET, queryset  =products )
    elif  category.type == 10:
        clothing_products = models.ClothingProduct.objects.filter(category = category, structure = 'parent',)
        filter  = filters.ClothingProductsFilter(request.GET, queryset = clothing_products )
        template = 'main/select_product/clothing_product.html'
    elif  category.type == 20:
        footwear_products = models.FootwearProduct.objects.filter(category = category, structure = 'parent',)
        filter  = filters.FootwearProductsFilter(request.GET, queryset = footwear_products )
        template = 'main/select_product/footwear_product.html'
    elif  category.type == 30:
        bags = models.Bag.objects.filter(category = category)
        filter  = filters.BagsFilter(request.GET, queryset = bags )
        template = 'main/select_product/bags.html'
    elif  category.type == 35:
        wallets = models.Wallet.objects.filter(category = category)
        filter  = filters.WalletsFilter(request.GET, queryset = wallets)
        template = 'main/select_product/wallets.html'
    elif  category.type == 40:
        watches  = models.Watch.objects.filter(category = category)
        filter  = filters.WatchesFilter(request.GET, queryset = watches )
        template = 'main/select_product/watches.html'

    args = {}
    args['filter'] = filter
    args['category'] = category
    return render(request, template, args)


# Function for adding a new product
# After checking the already registered ones
@login_required
@seller_has_company
def add_product(request):
    category = models.ProductCategory.objects.get(id = request.session['category_id'])
    manufacturer_form = forms.ManufacturerForm(request.POST or None, prefix = 'manufacturer')
    image_formset = forms.ProductImageFormSet(request.POST or None, request.FILES or None,
        queryset= models.ProductImage.objects.none())

    tags_form = forms.AddProductTagsForm(request.POST or None)

    if category.type == 0:
        product_form = forms.AddProductForm(request.POST or None)
    elif category.type == 10:
        product_form = forms.AddClothingProductForm(request.POST or None)
        template = 'main/add_product/clothing_product.html'
    elif category.type == 20:
        product_form = forms.AddFootwearProductForm(request.POST or None)
        template = 'main/add_product/footwear_product.html'
    elif category.type == 30:
        product_form = forms.AddBagsForm(request.POST or None)
        template = 'main/add_product/bags.html'
    elif category.type == 35:
        product_form = forms.AddWalletsForm(request.POST or None)
        template = 'main/add_product/wallets.html'
    elif category.type == 40:
        product_form = forms.AddWatchesForm(request.POST or None)
        template = 'main/add_product/watches.html'


    if request.method == "POST":
        if all([product_form.is_valid() and image_formset.is_valid() and manufacturer_form.is_valid()]):

            product = product_form.save(commit=False)
            manufacturer_name = manufacturer_form.save(commit=False)
            manufacturer , created  = models.Manufacturer.objects.get_or_create(name = manufacturer_name.name)

            if category.type == 10 or category.type == 20:
                product.structure = 'parent'

            elif category.type == 0 or category.type == 30 or category.type == 35 or category.type == 40:
                product.structure = 'standalone'

            product.manufacturer = manufacturer
            product.category = category
            product.save()
            tags = tags_form.save(commit=False)
            tags.product = product.product_ptr
            tags.save()
            tags_form.save_m2m()
            for form in image_formset.cleaned_data:
                if 'image' in form:
                    image = form['image']
                    photo = models.ProductImage(product=product, image=image)
                    photo.save()

            return redirect('product_manage', pk = product.id, category_type = product.category.type)

    args = {}
    args['manufacturer_form'] = manufacturer_form
    args['tags_form'] = tags_form
    args['image_formset'] = image_formset
    args['product_form'] = product_form
    args['category'] = category

    return render(request, template, args)

# Function for product processing.
@login_required
@seller_has_company
def product_processing(request, pk):
    product = models.Product.objects.get(id = pk)
    manufacturer_form = forms.ManufacturerForm(request.POST or None, instance = product.manufacturer, prefix = 'manufacturer')
    image_formset = forms.ProductImageFormSet(request.POST or None, request.FILES or None,
                   queryset= models.ProductImage.objects.filter(product = product))

    tags_form = forms.AddProductTagsForm(request.POST or None,  instance = product)

    if product.category.type == 0:
        product_form = forms.AddProductForm(request.POST or None,  instance = product)
    elif product.category.type == 10:
        product_form = forms.AddClothingProductForm(request.POST or None,  instance = product.clothingproduct)
        template = 'main/product_processing/clothing_product.html'
    elif product.category.type == 20:
        product_form = forms.AddFootwearProductForm(request.POST or None,  instance = product.footwearproduct)
        template = 'main/product_processing/footwear_product.html'
    elif product.category.type == 30:
        product_form = forms.AddBagsForm(request.POST or None,  instance = product.bag)
        template = 'main/product_processing/bags.html'
    elif product.category.type == 35:
        product_form = forms.AddWalletsForm(request.POST or None,  instance = product.wallet)
        template = 'main/product_processing/wallets.html'
    elif product.category.type == 40:
        product_form = forms.AddWatchesForm(request.POST or None,  instance = product.watch)
        template = 'main/product_processing/watches.html'

    if request.method == "POST":
        if all([product_form.is_valid() and image_formset.is_valid() and manufacturer_form.is_valid()]):

            product = product_form.save(commit=False)
            tags = tags_form.save(commit=False)

            if 'name' in  product_form.changed_data:
                product.product_ptr.name  = product_form.cleaned_data['name']

            if 'name' in manufacturer_form.changed_data:
                manufacturer , created  = models.Manufacturer.objects.get_or_create(name = manufacturer_form.save(commit=False))
                product.product_ptr.manufacturer = manufacturer

            tags.product = product.product_ptr
            product.save()
            tags.save()
            tags_form.save_m2m()

            for form in image_formset:
                if ('image' in form.cleaned_data) and form.has_changed():
                    if form.instance.pk:
                        prev_image = models.ProductImage.objects.get(pk=form.instance.pk)
                        prev_image.delete()
                    delete = form.cleaned_data.get("DELETE")
                    if not delete:
                        image = form.save(commit = False)
                        photo = models.ProductImage(product=product, image=image.image)
                        photo.save()

            return redirect('product_manage', pk=product.id , category_type=product.category.type)

    args = {}
    args['manufacturer_form'] = manufacturer_form
    args['tags_form'] = tags_form
    args['image_formset'] = image_formset
    args['product_form'] = product_form
    args['product'] = product

    return render(request, template, args)

class ProductDetailView(mixins.UserHasCompanyMixin, DetailView):
    model = models.Product
    template_name = "main/product_details.html"


# View all seller s bids (includes expired bids).
@login_required
@seller_has_company
def offers_list(request):
    offers = models.Offer.objects.filter(company = request.user.seller.owns_company)
    filter  = filters.OffersFilter(request.GET, queryset=offers)
    return render(request, 'main/offers_list.html', {'filter': filter})

# Presentation of details of an offer.
class OfferDetailView(mixins.UserHasCompanyMixin, DetailView):
    model = models.Offer
    template_name = 'main/offer_details.html'

# View the list of products that the seller has.
@login_required
@seller_has_company
def sales_list(request):
    sales = models.Sale.objects.filter(company = request.user.seller.owns_company)
    filter  = filters.SaleFilter(request.GET, queryset=sales )

    return render(request, 'main/sales_list.html', {'filter': filter})

# Manage the page to view and edit (purchase completion) the details of a sale.
@login_required
@seller_has_company
def sale_details(request, pk, prv_pg):
    args = {}
    sale = models.Sale.objects.get(id = pk)
    form = forms.SaleForm(request.POST or None, instance=sale)

    args['sale'] = sale
    args['form'] = form


    if sale.product.category.type == 10:
        template = 'main/sale_details/clothing_product.html'
    elif sale.product.category.type == 20:
        template = 'main/sale_details/footwear_product.html'
    elif sale.product.category.type == 30:
        template = 'main/sale_details/bag.html'
    elif sale.product.category.type == 35:
        template = 'main/sale_details/wallet.html'
    elif sale.product.category.type == 40:
        template = 'main/sale_details/watch.html'

    if request.method == 'POST':
        if form.is_valid():
            form.save()
            if prv_pg == 'home':
                return redirect('home')

            return redirect('sales_list')

    return render(request, template,  args)


# Function for displaying sales statistics with year and month option.
@login_required
@seller_has_company
def charts_view(request):
    current_date = timezone.now()
    days = calendar.monthrange(current_date.year, current_date.month)
    month = current_date.month
    year = current_date.year

    # Year and month selection form for viewing the corresponding data.
    form = forms.PeriodSelectForm(request.POST or None, initial={'month': month,'year': year})

    if request.method == "POST":
        if form.is_valid():
            month = form.cleaned_data["month"]
            year = form.cleaned_data["year"]
            days = calendar.monthrange(year, month)


    incomes_per_day_dataset = models.Sale.objects.filter(company = request.user.seller.owns_company,
        date_updated__year = year , date_updated__month = month, paid_with_money = True,
        status = 20) \
        .annotate(day=ExtractDay('date_updated'),) \
        .values('day') \
        .annotate(total = Sum(
                    F('quantity') *
                    F('selling_price'),
                    output_field=django_models.FloatField()
                )) \
        .order_by('day')

    incomes_per_month_dataset = models.Sale.objects.filter(company = request.user.seller.owns_company,
        date_updated__year = year, paid_with_money = True,
        status = 20) \
        .annotate(month=ExtractMonth('date_updated'),) \
        .values('month') \
        .annotate(total = Sum(
                    F('quantity') *
                    F('selling_price'),
                    output_field=django_models.FloatField()
                )) \
        .order_by('month')

    most_bought_products = models.Sale.objects.filter(company = request.user.seller.owns_company,
        date_updated__year = year, status = 20) \
        .values("product__name",) \
        .annotate(total = Sum('quantity')) \
        .order_by('total')[:5]


    paid_with_dataset = models.Sale.objects.filter(company = request.user.seller.owns_company,
    date_updated__year = year, status = 20) \
        .values("paid_with_money",) \
        .annotate(total = Sum(
                    F('quantity') *
                    F('selling_price'),
                    output_field=django_models.FloatField()
                ))

    daysIncomeIndexes = [x["day"] for x in incomes_per_day_dataset]
    daysIncomeValues = [x["total"] for x in incomes_per_day_dataset]

    monthsIncomeIndexes = [x["month"] for x in incomes_per_month_dataset]
    monthsIncomeValues = [x["total"] for x in incomes_per_month_dataset]

    mostBoughtProductsNames = [x["product__name"] for x in most_bought_products]
    mostBoughtProductsQuantities = [x["total"] for x in most_bought_products]

    paidWithMoney = 0
    paidWithPoints = 0

    for paid_with in paid_with_dataset:
        if paid_with["paid_with_money"]:
            paidWithMoney = paid_with["total"]
        else:
            paidWithPoints = paid_with["total"]



    args={}
    args['form'] = form
    args['month'] = month
    args['year'] = year
    args['daysIncomeIndexes'] = json.dumps(daysIncomeIndexes)
    args['daysIncomeValues'] = json.dumps(daysIncomeValues)
    args['monthsIncomeIndexes'] = json.dumps(monthsIncomeIndexes)
    args['monthsIncomeValues'] = json.dumps(monthsIncomeValues)
    args['mostBoughtProductsNames'] = json.dumps(mostBoughtProductsNames)
    args['mostBoughtProductsQuantities'] = json.dumps(mostBoughtProductsQuantities)
    args['paidWithPoints'] = paidWithPoints
    args['paidWithMoney'] = paidWithMoney

    return render(request, 'main/charts.html',  args)

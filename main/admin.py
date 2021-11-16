from django.contrib import admin
from django.utils.html import format_html
from django_google_maps import widgets as map_widgets
from django_google_maps import fields as map_fields
from mptt.admin import DraggableMPTTAdmin
from . import models
from django.contrib.auth.admin import UserAdmin as DjangoUserAdmin

# Set admin handler for connecting custom users.
@admin.register(models.User)
class UserAdmin(DjangoUserAdmin):
    fieldsets = (
        (None, {"fields": ("email", "password")}),
        (
            "Personal info",
            {"fields": ("first_name", "last_name",)},
        ),
        (
            "Permissions",
            {
                "fields": ('is_seller', 'is_customer', "is_active", "is_staff", "is_superuser",
                    "groups", "user_permissions",)
            },
        ),
        (
            "Important dates", {"fields": ("last_login", "date_joined")},
        ),
    )
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("email", "password1", "password2"),
            },
        ),
    )
    list_display = ("id", "email", "first_name", "last_name", "is_seller","is_customer")
    list_filter = ('is_seller',"is_customer")
    search_fields = ("email", )
    ordering = ("id",)

class CustomerAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('user','orange_points', )
    # Editable fields.
    list_editable = ('orange_points',)
    # Search fields
    search_fields = ('user',)

admin.site.register(models.Customer, CustomerAdmin)

class SellerAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('user',)

    # Search fields
    search_fields = ('user',)

admin.site.register(models.Seller, SellerAdmin)


# Customization of the Admin interface to something more friendly than the default version.
class CompanyAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','owner', 'name', 'category',)
    # Filter fields.
    list_filter = ('category',)
    # Editable fields.
    list_editable = ('name','category',)
    # Search fields
    search_fields = ('id','owner', 'name','category',)
    # Slug creation.
    prepopulated_fields = {"slug": ("name",)}

admin.site.register(models.Company, CompanyAdmin)



# Customization of the Admin interface to something more friendly than the default version.
class SalesProductAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','company','product','price' , 'quantity', )
    # Filter fields.
    list_filter = ('company', 'date_updated',)
    # Editable fields.
    list_editable = ('quantity','price',)
    # Search fields
    search_fields = ('id','company', 'product',)
    # Slug creation.

admin.site.register(models.SalesProduct, SalesProductAdmin)


@admin.register(models.Sale)
class SaleAdmin(admin.ModelAdmin):
    list_display = ("id", "customer",'product','quantity', 'company' ,'status','date_added', 'date_updated',)
    list_editable = ("status",)
    list_filter = ("customer",'product','company' ,'status', "date_added")

@admin.register(models.Favorite)
class FavoriteAdmin(admin.ModelAdmin):
    list_display = ("id", "customer",'product','date_added',)
    list_filter = ("customer",'product', "date_added")


class OfferAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_name', 'company_name',
        'is_open', 'has_expired' ,'start_date' ,'end_date',)
    list_editable = ('is_open', 'has_expired')
    list_filter = ('is_open', 'has_expired','start_date' ,'end_date',)

    def product_name(self, obj):

        if obj.offer is None:
            return 'IS NOT EXIST'
        return obj.offer.product.name

    def company_name(self, obj):
        if obj.offer is None:
            return 'IS NOT EXIST'
        return obj.offer.company.name

admin.site.register(models.Offer, OfferAdmin)

# Customization of the Admin interface to something more friendly than the default version.
@admin.register(models.Manufacturer)
class ManufacturerAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','slug',)
    # Filter fields.
    list_filter = ('name',)
    # Editable fields.
    list_editable = ('name',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)
    # Slug creation.
    prepopulated_fields = {"slug": ("name",)}


# Customization of the Admin interface to something more friendly than the default version.
class ProductAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category', 'slug', 'tag_list',)
    # Filter fields.
    list_filter = ('structure','active', 'date_updated',)
    # Editable fields.
    list_editable = ('name','category')
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('tags')

    def tag_list(self, obj):
        return u", ".join(o.name for o in obj.tags.all())

admin.site.register(models.Product, ProductAdmin)


class ProductImageAdmin(admin.ModelAdmin):
    list_display = ('thumbnail_tag', 'product_name')
    readonly_fields = ('thumbnail',)
    search_fields = ('product_id', 'product_name',)

    def thumbnail_tag(self, obj):
        if obj.thumbnail:
            return format_html(
                '<img src="%s"/>' % obj.thumbnail.url
            )
        return "-"
    thumbnail_tag.short_description = "Thumbnail"
    def product_name(self, obj):
        return obj.product.name

admin.site.register(models.ProductImage, ProductImageAdmin)


class ProductCategoryAdmin(DraggableMPTTAdmin):
    mptt_indent_field = "name"
    list_display = ('tree_actions', 'id','indented_title',
                    'related_products_count', 'related_products_cumulative_count')
    list_display_links = ('indented_title',)

    def get_queryset(self, request):
        qs = super().get_queryset(request)

        # Add cumulative product count
        qs = models.ProductCategory.objects.add_related_count(
                qs,
                models.Product,
                'category',
                'products_cumulative_count',
                cumulative=True)

        # Add non cumulative product count
        qs = models.ProductCategory.objects.add_related_count(qs,
                 models.Product,
                 'category',
                 'products_count',
                 cumulative=False)
        return qs

    def related_products_count(self, instance):
        return instance.products_count

    related_products_count.short_description = 'Related products (for this specific category)'

    def related_products_cumulative_count(self, instance):
        return instance.products_cumulative_count

    related_products_cumulative_count.short_description = 'Related products (in tree)'

    prepopulated_fields = {"slug": ("name",)}

admin.site.register(models.ProductCategory, ProductCategoryAdmin)

class CompanyCategoryAdmin(DraggableMPTTAdmin):
    mptt_indent_field = "name"
    list_display = ('tree_actions', 'indented_title',
                    'related_companies_count', 'related_companies_cumulative_count')
    list_display_links = ('indented_title',)

    def get_queryset(self, request):
        qs = super().get_queryset(request)

        # Add cumulative product count
        qs = models.CompanyCategory.objects.add_related_count(
                qs,
                models.Company,
                'category',
                'companies_cumulative_count',
                cumulative=True)

        # Add non cumulative product count
        qs = models.CompanyCategory.objects.add_related_count(
                qs,
                 models.Company,
                 'category',
                 'companies_count',
                 cumulative=False)
        return qs

    def related_companies_count(self, instance):
        return instance.companies_count

    related_companies_count.short_description = 'Related companies (for this specific category)'

    def related_companies_cumulative_count(self, instance):
        return instance.companies_cumulative_count

    related_companies_cumulative_count.short_description = 'Related companies (in tree)'

    prepopulated_fields = {"slug": ("name",)}

admin.site.register(models.CompanyCategory, CompanyCategoryAdmin)

# Show location map
class CompanyLocationAdmin(admin.ModelAdmin):
    list_display = ('id','address', 'slug', 'company',)
    prepopulated_fields = {"slug": ("address",)}
    formfield_overrides = {
        map_fields.AddressField: {'widget': map_widgets.GoogleMapsAddressWidget},
        }

admin.site.register(models.CompanyLocation, CompanyLocationAdmin)

# Show location map
class CustomerLocationAdmin(admin.ModelAdmin):
    list_display = ('id','address', 'slug', 'customer',)
    prepopulated_fields = {"slug": ("address",)}
    formfield_overrides = {
        map_fields.AddressField: {'widget': map_widgets.GoogleMapsAddressWidget},
        }

admin.site.register(models.CustomerLocation, CustomerLocationAdmin)


# Customization of the Admin interface to something more friendly than the default version.
class ClothingProductAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category','size','color', 'slug', 'tag_list',)
    # Filter fields.
    list_filter = ('structure','active', 'size','color','date_updated',)
    # Editable fields.
    list_editable = ('name','category','size','color',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('tags')

    def tag_list(self, obj):
        return u", ".join(o.name for o in obj.tags.all())

admin.site.register(models.ClothingProduct, ClothingProductAdmin)

# Shoe management.
class FootwearProductAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category','size','color', 'slug')
    # Filter fields.
    list_filter = ('structure','active', 'size','color','date_updated',)
    # Editable fields.
    list_editable = ('name','category','size','color',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

admin.site.register(models.FootwearProduct, FootwearProductAdmin)


# Bags management.
class  BagAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category','color', 'material', 'type',)
    # Filter fields.
    list_filter = ('structure','active', 'color','date_updated',)
    # Editable fields.
    list_editable = ('name','category','color',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

admin.site.register(models.Bag, BagAdmin)

# Wallets management.
class  WalletAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category','type','type_of_closing','color', 'material',)
    # Filter fields.
    list_filter = ('structure','active', 'color','date_updated',)
    # Editable fields.
    list_editable = ('name','category','type','type_of_closing','color', 'material',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

admin.site.register(models.Wallet, WalletAdmin)


# Clocks management.
class  WatchAdmin(admin.ModelAdmin):
    # Fields that appear in the list
    list_display = ('id','name','manufacturer','category','display','mechanism','band_material', 'band_color', 'face_color', 'water_resistance',)
    # Filter fields.
    list_filter = ('structure','active', 'display','date_updated',)
    # Editable fields.
    list_editable = ('name','category','display','mechanism','band_material', 'band_color', 'face_color', 'water_resistance',)
    # Search fields
    search_fields = ('id', 'name', 'slug',)

    autocomplete_fields = ('manufacturer',)

admin.site.register(models.Watch, WatchAdmin)

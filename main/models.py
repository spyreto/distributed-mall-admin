from django.db import models
from django_google_maps import fields as map_fields
from mptt.models import MPTTModel, TreeForeignKey
from django.contrib.auth.models import (
    AbstractUser, BaseUserManager,
)

from django.core.validators import MinValueValidator
from phonenumber_field.modelfields import PhoneNumberField

from slugify import slugify

from django.core import exceptions

from taggit.managers import TaggableManager
import datetime

COLORS = (
    ('red', "Red"),
    ('pink', 'Pink'),
    ('lightpink', 'Rose'),
    ('orange', 'Orange'),
    ('Gold', 'Gold'),
    ('yellow', 'Yellow'),
    ('purple', 'Purple'),
    ('green', 'Green'),
    ('blue', "Blue"),
    ('LightBlue', 'Blue'),
    ('brown', 'Brown'),
    ('gray', 'Gray'),
    ('silver', 'Silver'),
    ('beige', 'Beige'),
    ('black', 'Black'),
    ('white', 'White'),
)

# Τροποποίηση του built-in User model
class UserManager(BaseUserManager):
    use_in_migrations = True
    def _create_user(self, email, password,**extra_fields):
        if not email:
            raise ValueError("The given email must be set")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", False)
        extra_fields.setdefault("is_superuser", False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        if extra_fields.get("is_staff") is not True:
           raise ValueError(
               "Superuser must have is_staff=True."
           )
        if extra_fields.get("is_superuser") is not True:
            raise ValueError(
               "Superuser must have is_superuser=True."
           )
        return self._create_user(email, password, **extra_fields)

# Modify the built-in User model so that the email is the username
class User(AbstractUser):
    username = None
    email = models.EmailField('email', unique=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    is_seller = models.BooleanField(default=False)
    is_customer = models.BooleanField(default=False)

    objects = UserManager()

#.........................................
class Seller(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)

    def __str__(self):
        return self.user.email

#.........................................
class Customer(models.Model):
    MALE = 10
    FEMALE = 20
    GENDERS = (
        (MALE, "Man"),
        (FEMALE, "Woman"),
    )

    birth_date = models.DateField(null=True, blank=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    gender = models.IntegerField(choices=GENDERS, default=MALE)
    phone_number = PhoneNumberField()
    device_id = models.CharField(max_length=50)
    orange_points = models.IntegerField(default=0)

    def __str__(self):
        return self.user.email

# Company model management class.
class Company(models.Model):
    class Meta:
        verbose_name_plural = 'Companies'

    owner = models.OneToOneField('Seller', related_name="owns_company", on_delete=models.CASCADE)
    category = TreeForeignKey('CompanyCategory', null=True,
     related_name="company_category", on_delete=models.SET_NULL)
    description = models.TextField(blank=True)
    name = models.CharField(max_length=50)
    slug = models.SlugField(max_length=48)

    def __str__(self):
        return self.name

def createCompany(sender, **kwargs):
     if kwargs['created']:
         owns_company = Company.objects.created(user=kwargs['instance'])

         post_save.connect(createCompany, sender=Seller)

# Class for store category (eg clothing store, restaurant)
class CompanyCategory(MPTTModel):
    name = models.CharField(max_length=64, unique=True)
    slug = models.SlugField(max_length=48)
    parent = TreeForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='children')

    def __str__(self):
        return self.name

    class MPTTMeta:
        verbose_name = "Company Category"
        verbose_name_plural = "Companies Categories"
        order_insertion_by = ['name']

# Sales model class.
class SalesProduct(models.Model):
    company = models.ForeignKey('Company', related_name="sales_product",on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.PROTECT)
    price = models.DecimalField(max_digits=8, decimal_places=2, default=0)
    quantity = models.PositiveIntegerField(default=0,)
    date_updated = models.DateTimeField(auto_now=True)

    def get_product_category(self):
        return self.product.product_category

    def __str__(self):
        return f"{self.company} sales {self.product} for {self.price}"

# Model class of the order-purchase table
class Sale(models.Model):
    # Order Status
    PROCESSING = 10
    CONFIRMED = 20
    CANCELLED = 30
    STATUSES = (
        (PROCESSING, "In process"),
        (CONFIRMED, "Confirmed"),
        (CANCELLED, "Canceled"),
    )

    customer = models.ForeignKey('Customer', on_delete=models.CASCADE)
    company = models.ForeignKey('Company', on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.PROTECT)

    quantity = models.PositiveIntegerField(default=0, validators=[MinValueValidator(1)])

    selling_price = models.DecimalField(max_digits=6, decimal_places=2, default=0)

    status = models.IntegerField(choices=STATUSES, default=PROCESSING,
        help_text=("The possibility of changing the status concerns a period of 7 days."))

    # Payment method (money or points)
    paid_with_money = models.BooleanField(default=True)

    date_updated = models.DateTimeField(auto_now=True)
    date_added = models.DateTimeField(auto_now=True)

# User's favorite product model class.
class Favorite(models.Model):
    customer = models.ForeignKey('Customer', on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    date_added = models.DateTimeField(auto_now=True)

# Offer class
class Offer(models.Model):

    is_open = models.BooleanField(default=False)
    has_expired = models.BooleanField(default=False)

    number_of_customers = models.PositiveIntegerField(default=0)

    product = models.ForeignKey('Product', on_delete=models.PROTECT)
    company = models.ForeignKey('Company', on_delete=models.PROTECT)

    offer = models.ForeignKey('SalesProduct',related_name="offer", on_delete=models.SET_NULL, null=True)

    start_date= models.DateField(blank=True, null=True,
        help_text=("Leave blank if the offer does not have a start day."))
    end_date = models.DateField(blank=True, null=True,
        help_text=("Leave blank if the offer does not have an expiration date."))

    discount_rate = models.DecimalField(max_digits=4, decimal_places=1, default=0)
    discount_price = models.DecimalField(max_digits=8, decimal_places=2, default=0)

    def __str__(self):
        return f"{self.company.name} offers {self.product.name} for {self.discount_rate}%"

    def save(self, *args, **kwargs):
        if not self.is_open:
            self.has_expired = True
            self.end_date = datetime.date.today()
        super().save(*args, **kwargs)


    def clean(self):
        if (self.start_date and self.end_date
                and self.start_date > self.end_date):
            raise exceptions.ValidationError('The closing date of the offer must be later than the beginning')
        if  (self.end_date and self.end_date < datetime.date.today()):
            raise exceptions.ValidationError('The closing date of the offer is earlier than today.')


# Manufacturer class.
class Manufacturer(models.Model):
    name = models.CharField(max_length=64)
    slug = models.SlugField(max_length=64)

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class ActiveManager(models.Manager):
    def active(self):
        return self.filter(active=True)

# Product model.
class Product(models.Model):
    STANDALONE, PARENT, CHILD = 'standalone', 'parent', 'child'

    STRUCTURE_CHOICES = (
        (STANDALONE, 'Stand-alone product'),
        (PARENT, 'Parent product'),
        (CHILD, 'Child product')
    )

    structure = models.CharField( max_length=10, choices=STRUCTURE_CHOICES,
        default=STANDALONE)
    name = models.CharField(max_length=64)
    slug = models.SlugField(max_length=64)
    active = models.BooleanField(default=True)
    date_updated = models.DateTimeField(auto_now=True)
    objects = ActiveManager()
    category = TreeForeignKey('ProductCategory', null=True,
        related_name="product_category", on_delete=models.SET_NULL)
    tags = TaggableManager(blank=True)
    description = models.TextField(blank=True)
    manufacturer = models.ForeignKey(Manufacturer,related_name="product_manufacturer",
        null=True, on_delete=models.SET_NULL)

    parent = models.ForeignKey('self',blank=True,null=True,
        on_delete=models.CASCADE, related_name='children', verbose_name=("Parent product"),
        help_text=("Only choose a parent product if you're creating a child "
                    "product.  For example if this is a size "
                    "4 of a particular t-shirt.  Leave blank if this is a "
                    "stand-alone product (i.e. there is only one version of"
                    " this product)."))


    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


# Product category class.
class ProductCategory(MPTTModel):
    # Payment method (money or points).
    BASIC = 0
    CLOTHING = 10
    FOOTWEAR = 20
    BAGS = 30
    WALLETS = 35
    WATCHES = 40
    CATEGORY = (
        (BASIC, "Basic"),
        (CLOTHING, "Clothing"),
        (FOOTWEAR, 'Footwear'),
        (BAGS, 'Bags'),
        (WALLETS, 'Wallets'),
        (WATCHES, 'Watches'),
    )

    name = models.CharField(max_length=64)
    slug = models.SlugField(max_length=48)
    type = models.IntegerField(choices=CATEGORY, default=BASIC)
    parent = TreeForeignKey('self', on_delete=models.CASCADE, null=True,
        blank=True, related_name='children')

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    class MPTTMeta:
        verbose_name = "Product Category"
        verbose_name_plural = "Products Categories"
        order_insertion_by = ['name']

# Products images model
class ProductImage(models.Model):
    product = models.ForeignKey(
        Product,related_name='image', on_delete=models.CASCADE
    )
    image = models.ImageField(upload_to="product-images")
    thumbnail = models.ImageField(
        upload_to="product-thumbnails", null=True
    )

# Location model.
class Location(models.Model):
    address = map_fields.AddressField(max_length=200)
    slug = models.SlugField(max_length=48)
    geolocation = map_fields.GeoLocationField(max_length=100)

    def __str__(self):
            return self.address

# Company location model.
class CompanyLocation(Location):
    class Meta:
        verbose_name_plural = 'Companies Locations'

    company =  models.OneToOneField('Company', related_name='location', on_delete=models.CASCADE)


# Cusromer-user location model.
class CustomerLocation(Location):
    customer =  models.OneToOneField('Customer', related_name='location', on_delete=models.CASCADE)

    def __str__(self):
        return self.address

# Clothing products model
class ClothingProduct(Product):
    #...........
    XXS = 10
    XS = 20
    S = 30
    M = 40
    L = 50
    XL = 60
    XXL = 70
    SIZES = (
        (XXS, 'XXS'),
        (XS, 'XS'),
        (S, 'S'),
        (M, 'M'),
        (L, 'L'),
        (XL, 'XL'),
        (XXL, 'XXL'),
    )

    MATERIALS = (
        ('LEATHER', "Leather"),
        ('COTTON', 'Cotton'),
        ('WOOL', 'Wool'),
        ('POLYESTER', 'Polyester'),
        ('OTHER', 'Other')
    )

    size = models.IntegerField(choices=SIZES, default=M)
    color =  models.CharField(max_length=15, choices=COLORS,
        default='white', )
    material = models.CharField( max_length=15, choices=MATERIALS,
        default='COTTON')

# Footwear products model
class FootwearProduct(Product):

    COLORS = (
        ('red', "Red"),
        ('pink', 'Pink'),
        ('orange', 'Orange'),
        ('yellow', 'Yellow'),
        ('purple', 'Purple'),
        ('green', 'Green'),
        ('blue', "Blue"),
        ('LightBlue', 'Blue'),
        ('brown', 'Brown'),
        ('gray', 'Gray'),
        ('black', 'Black'),
        ('white', 'White'),
    )

    MATERIALS = (
        ('LEATHER', "Leather"),
        ('TEXTILE', 'Cotton'),
        ('SYNTHETIC', 'Synthetics'),
        ('LEATHERETTE', 'Leatherette'),
        ('OTHER', 'Other')
    )

    size = models.CharField(max_length=15, choices=COLORS,
        default='')
    color =  models.CharField(max_length=15, choices=COLORS,
        default='white')
    material = models.CharField( max_length=15, choices=MATERIALS,
        default='COTTON')


# Backpack-bag product class.
class Bag(Product):

    MATERIALS = (
        ('LEATHER', "Leather"),
        ('TEXTILE', 'Fabric'),
        ('SYNTHETIC', 'Synthetic'),
        ('LEATHERETTE', 'Leatherette'),
        ('OTHER', 'Other')
    )

    TYPES = (
        ('SHOULDER', 'Shoulder'),
        ('CROSSBOY', 'Cross'),
        ('TOTE', 'Hand'),
        ('BACKPACK', 'Back'),
        ('BRIEFCASE', 'Briefcase'),
        ('OTHER', 'Other')
    )

    type =  models.CharField(max_length=15, choices=TYPES,
        default='SHOULDER')
    color =  models.CharField(max_length=15, choices=COLORS,
        default='white')
    material = models.CharField( max_length=15, choices=MATERIALS,
        default='COTTON')

# Wallets class.
class Wallet(Product):

    MATERIALS = (
        ('LEATHER', "Leather"),
        ('TEXTILE', 'Fabric'),
        ('SYNTHETIC', 'Synthetics'),
        ('LEATHERETTE', 'Leatherette'),
        ('OTHER', 'Other')
    )

    TYPES = (
        ('CARDS', 'Cards'),
        ('COINS', 'Coins'),
        ('TRAVEL', 'Travel'),
        ('CLASSIC', 'Classic'),
        ('OTHER', 'Other')
    )

    TYPES_OF_CLOSING = (
        ('CLIP', 'Clip'),
        ('ZIPPER', 'Zipper'),
        ('VELCRO', 'Velcro'),
        ('CLASP', 'Clasp'),
        ('OTHER', 'Other')
    )

    type =  models.CharField(max_length=15, choices=TYPES, default='SHOULDER'  )
    type_of_closing =  models.CharField(max_length=15, choices=TYPES_OF_CLOSING,
        default='CLIP')
    color =  models.CharField(max_length=15, choices=COLORS,
        default='white')
    material = models.CharField( max_length=15, choices=MATERIALS,
        default='COTTON')

# Wallet class.
class Watch(Product):

    class Meta:
        verbose_name_plural = 'Watches'

    DISPLAYS = (
        ('ANALOG', 'Analog'),
        ('DIGITAL', 'Digital'),
    )

    BAND_MATERIALS = (
        ('METAL', 'Metallic'),
        ('LEATHER', 'Leather'),
        ('SILICONE', 'Silicone'),
        ('TEXTILE', 'Fabric'),
        ('OTHER', 'Other')
    )

    MECHANISMS = (
        ('AUTOMATIC', 'Auto'), 
        ('SOLAR', 'Solar'), 
        ('BATTERY', 'Battery'), 
        ('ECO DRIVE', 'Eco Drive'), 
        ('OTHER', 'Other' ),
    )

    WATER_RESISTANCE = (
       (0, 'No'),
       (2,'2 Atm'),
       (3,'3 Atm'),
       (5, '5 Amt'),
       (10, '10 Atm'),
       (20, '20 Atm'),
       (30, '30 Atm'),
       (40, '40 Atm'),
       (50, 'Over 40 Atm'),
   )

    display =  models.CharField(max_length=15, choices=DISPLAYS,
        default='ANALOG')

    mechanism =  models.CharField(max_length=15, choices=MECHANISMS,
        default='BATERY')

    band_material  = models.CharField( max_length=15, choices=BAND_MATERIALS,
        default='LEATHER')

    band_color =  models.CharField(max_length=15, choices=COLORS,
        default='white')

    face_color =  models.CharField(max_length=15, choices=COLORS,
        default='white')

    water_resistance = models.IntegerField(choices=WATER_RESISTANCE, default=5)

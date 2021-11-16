from io import BytesIO
import logging
from PIL import Image
from django.conf import settings
from django.core.files.base import ContentFile
from django.db.models.signals import pre_save, pre_delete, post_save
from django.dispatch import receiver
from .models import ProductImage, Sale, Offer, SalesProduct, Customer
from rest_framework.authtoken.models import Token

THUMBNAIL_SIZE = (200, 200)

logger = logging.getLogger(__name__)

@receiver(pre_save, sender=ProductImage)
def generate_thumbnail(sender, instance, **kwargs):
    logger.info(
        "Generating thumbnail for product %d",
        instance.product.id,
    )
    image = Image.open(instance.image)
    image = image.convert("RGB")
    image.thumbnail(THUMBNAIL_SIZE, Image.ANTIALIAS)

    temp_thumb = BytesIO()
    image.save(temp_thumb, "JPEG")
    temp_thumb.seek(0)

    # Set save=False, otherwise it will run in an infinite loop
    instance.thumbnail.save(
        instance.image.name,
        ContentFile(temp_thumb.read()),
        save=False,
    )
    temp_thumb.close()

# Delete image and thumbnail from media when removing a photo of a product
@receiver(pre_delete, sender=ProductImage)
def image_delete(sender, instance,  **kwargs):
    instance.image.delete(False)
    instance.thumbnail.delete(False)


@receiver(pre_save, sender=Sale)
def calculate_user_points(sender, instance, **kwargs):
    orange_points = int(instance.quantity * instance.selling_price)
    customer = instance.customer

    if instance.paid_with_money:
        if instance.status == 20:
            instance.customer.orange_points += 10*orange_points
            instance.customer.save()
        if instance.status == 30:
            instance.customer.orange_points += 10*orange_points
            instance.customer.save()
    else:
        if  instance.status == 10:
            instance.customer.orange_points -= 200*orange_points
            instance.customer.save()
        elif instance.status == 30:
            instance.customer.orange_points += 200*orange_points
            instance.customer.save()

    print(instance.customer.orange_points)

@receiver(pre_save, sender=Sale)
def change_quantity(sender, instance, **kwargs):
    quantity = instance.quantity
    sale_status = instance.status
    company = instance.company
    product = instance.product

    sales_product = SalesProduct.objects.get(company = company, product = product)

    if sale_status == 10:
        sales_product.quantity -= quantity
        sales_product.save()
    elif sale_status == 30:
        sales_product.quantity += quantity
        sales_product.save()

    
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)

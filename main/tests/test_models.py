from decimal import Decimal
from django.test import TestCase
from main import models

class TestModel(TestCase):
    def test_active_manager_works(self):

        models.ProductCategory.objects.create(
            name="Health - Beauty"
            )

        models.ProductCategory.objects.create(
            name="Face care",
            parent=models.ProductCategory.objects.get(name = "Health - Beauty")
            )

        models.Product.objects.create(
            name="Face cream",
            price=Decimal("10.00"),
            product_category=models.ProductCategory.objects.get(name = "Face care")
            )

        models.Product.objects.create(
            name="Black socks",
            price=Decimal("2.00"),
            product_category=models.ProductCategory.objects.get(name = "Face care")
            )

        models.Product.objects.create(
            name="The secrets of the swamp",
            price=Decimal("2.00"),
            product_category=models.ProductCategory.objects.get(name = "Face care"),
            active=False)

        self.assertEqual(len(models.Product.objects.active()), 2)

from decimal import Decimal
from django.test import TestCase
from main import models

class TestModel(TestCase):
    def test_active_manager_works(self):

        models.ProductCategory.objects.create(
            name="Υγεία - Ομορφία"
            )

        models.ProductCategory.objects.create(
            name="Περιποιήση προσώπου",
            parent=models.ProductCategory.objects.get(name = "Υγεία - Ομορφία")
            )

        models.Product.objects.create(
            name="Κρέμα προσώπου",
            price=Decimal("10.00"),
            product_category=models.ProductCategory.objects.get(name = "Περιποιήση προσώπου")
            )

        models.Product.objects.create(
            name="Κάλτσες μάυρες",
            price=Decimal("2.00"),
            product_category=models.ProductCategory.objects.get(name = "Περιποιήση προσώπου")
            )

        models.Product.objects.create(
            name="Τα μυστικά του βάλτου",
            price=Decimal("2.00"),
            product_category=models.ProductCategory.objects.get(name = "Περιποιήση προσώπου"),
            active=False)

        self.assertEqual(len(models.Product.objects.active()), 2)

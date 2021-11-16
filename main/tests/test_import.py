from io import StringIO
import tempfile
from django.conf import settings
from django.core.management import call_command
from django.test import TestCase, override_settings
from main import models


class TestImport(TestCase):
    @classmethod
    def setUpTestData(cls):
        #Δημιουργεία δεδομένων Category για το σύνολο των TestCases
        cls.testCat = models.ProductCategory.objects.create(
            name="TestCat")
        cls.testCat2 = models.ProductCategory.objects.create(
            name="TestCat2")

    def test_import_products_categories(self):
        out = StringIO()
        args = ['main/fixtures/products-categories-sample.csv',]

        call_command('import_products_categories', *args, stdout=out)

        expected_out = ("Importing products categories\n"
                        "Products categories processed=3 (created=3)\n")

        self.assertEqual(out.getvalue(), expected_out)
        self.assertEqual(models.ProductCategory.objects.count(), 5)

    def test_import_companies_categories(self):
        out = StringIO()
        args = ['main/fixtures/companies-categories-sample.csv',]

        call_command('import_companies_categories', *args, stdout=out)

        expected_out = ("Importing categories\n"
                        "Product categories processed=3 (created=3)\n")

        self.assertEqual(out.getvalue(), expected_out)
        self.assertEqual(models.ComapnyCategory.objects.count(), 5)

    @override_settings(MEDIA_ROOT=tempfile.gettempdir())
    def test_import_products(self):
        out = StringIO()
        args = ['main/fixtures/product-sample.csv',
                'main/fixtures/product-sampleimages/',]

        call_command('import_products', *args, stdout=out)

        expected_out = ("Importing products\n"
                        "--There isn't product category with id=15\n"
                        "---The product \"Backgammon for dummies\" is not registered\n"
                        "Products processed=2 (created=2)\n"
                        "Tags processed=4 (created=4)\n"
                        "Images processed=2\n")

        self.assertEqual(out.getvalue(), expected_out)
        self.assertEqual(models.Product.objects.count(), 2)
        self.assertEqual(models.ProductTag.objects.count(), 4)
        self.assertEqual(models.ProductImage.objects.count(), 2)

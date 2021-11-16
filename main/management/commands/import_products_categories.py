# Products import command via CSV file.
from collections import Counter
import csv
import os.path
from django.core.management.base import BaseCommand
from django.template.defaultfilters import slugify
from main import models

class Command(BaseCommand):
    help = "Import products categories in Distributed Mall"
    def add_arguments(self, parser):
        parser.add_argument("csvfile", type=open)

    def handle(self, *args, **options):
        c = Counter()
        reader = csv.DictReader(options.pop("csvfile"))
        self.stdout.write("Importing products categories")

        for row in reader:
            if row["parent"] == "":
                product_category, created = models.ProductCategory.objects.get_or_create(
                    name=row["name"],)

            else:
                product_category, created = models.ProductCategory.objects.get_or_create(
                    name=row["name"],
                    parent = models.ProductCategory.objects.get(id=row["parent"],),
                    type = row["type"],
                )
                product_category.save()
                self.stdout.write(product_category.slug)

            c["products_categories"] += 1

            if created:
                c["products_categories_created"] += 1

        self.stdout.write(
            "Products categories processed=%d (created=%d)"
            % (c["products_categories"], c["products_categories_created"])
        )

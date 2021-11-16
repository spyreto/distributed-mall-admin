# Products import command via CSV file.
from collections import Counter
import csv
import os.path
import argparse
from django.core.management.base import BaseCommand
from django.template.defaultfilters import slugify
from main import models

from django.db.utils import IntegrityError

class Command(BaseCommand):
    help = "Import companies categories in Distributed Mall"
    def add_arguments(self, parser):
        parser.add_argument("csvfile", type=argparse.FileType('r', encoding='utf-8'))

    def handle(self, *args, **options):
        c = Counter()
        reader = csv.DictReader(options.pop("csvfile"))
        self.stdout.write("Importing companies categories")

        for row in reader:
            if row["parent"] == "":
                company_category, created = models.CompanyCategory.objects.get_or_create(
                    name=row["name"],)

            else:
                try:
                    company_category, created = models.CompanyCategory.objects.get_or_create(
                        name=row["name"],
                        parent = models.CompanyCategory.objects.get(id=row["parent"],),
                    )
                except IntegrityError:
                    models.CompanyCategory.objects.filter(name=row["name"],).delete()

                    company_category, changed = models.CompanyCategory.objects.get_or_create(
                        name=row["name"],
                        parent = models.CompanyCategory.objects.get(id=row["parent"],),
                    )

            company_category.slug = slugify(row["name"])

            c["companies_categories"] += 1

            if created:
                c["companies_categories_created"] += 1

        self.stdout.write(
            "Companies categories processed=%d (created=%d)"
            % (c["companies_categories"], c["companies_categories_created"])
        )

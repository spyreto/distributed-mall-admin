# Products import command via CSV file.
from collections import Counter
from django.core.exceptions import ObjectDoesNotExist
import csv
import os.path
from django.core.files.images import ImageFile
from django.core.management.base import BaseCommand
from main import models

from taggit.managers import TaggableManager

class Command(BaseCommand):
    help = "Import footwear products in Distributed Mall"
    def add_arguments(self, parser):
        parser.add_argument("csvfile", type=open)
        parser.add_argument("image_basedir", type=str)

    def handle(self, *args, **options):
        c = Counter()
        reader = csv.DictReader(options.pop("csvfile"))
        self.stdout.write("Importing footwear products")

        for row in reader:
            # Exception handling in case the product category listed in csvfile
            # does not exist
            try:
                manufacturer, created = models.Manufacturer.objects.get_or_create(name = row["manufacturer"])

                product, created = models.FootwearProduct.objects.get_or_create(
                    name=row["name"],
                    description=row["description"],
                    structure='parent',
                    category = models.ProductCategory.objects.get(id=row["category"]),
                    manufacturer = manufacturer,
                    material = row["material"],
                    color = row["color"],
                )

                for import_tag in row["tags"].split("|"):
                    product.product_ptr.tags.add(import_tag + ',')
                    c["tags"] += 1

                for image_filename in row["images_filenames"].split("|"):
                    with open(
                        os.path.join(
                            options["image_basedir"],
                            image_filename,
                        ),
                        "rb",
                    ) as f:
                        image = models.ProductImage(
                            product=product,
                            image=ImageFile(
                                f, name=image_filename
                            ),
                        )
                        image.save()
                        c["images"] += 1

                product.save()
                c["products"] += 1
                if created:
                    c["products_created"] += 1

            except models.ProductCategory.DoesNotExist:
                    self.stdout.write(
                        "--There isn't product category with id=%s"
                        % (row["category"])
                    )
                    self.stdout.write(
                        "---The product \"%s\" is not registered"
                        % (row["name"])
                    )
                    continue

        self.stdout.write(
            "Footwear products processed=%d (created=%d)"
            % (c["products"], c["products_created"])
        )
        self.stdout.write(
            "Tags processed=%d " % (c["tags"])
        )
        self.stdout.write("Images processed=%d" % c["images"])

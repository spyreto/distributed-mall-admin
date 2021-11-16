# Products import command via CSV file.
from collections import Counter
from django.core.management.base import BaseCommand
from main import models

import datetime

class Command(BaseCommand):
    help = "Removes inactive manufacturers."

    def add_arguments(self, parser):
        parser.add_argument('-l', '--list', action='store_true', help='Prints out the list of removed manufacturers.')

    def handle(self, *args, **options):

        self.stdout.write("Removing inactive manufacturers.")
        c = Counter()
        c["manufacturers"] = models.Manufacturer.objects.count()
        c["removed"] = 0
        removed_items_list = []

        manufacturers = models.Manufacturer.objects.filter(product_manufacturer__isnull = True)

        for manufacturer in manufacturers:
            removed_items_list.append(manufacturer.name)
            manufacturer.delete()
            c["removed"] += 1

        self.stdout.write(
            "Removed Manufacturers = %d (Total = %d)."
            % (c["removed"] , c["manufacturers"] )
        )

        if options['list']:
            if c["removed"] > 0:
                self.stdout.write('Removed Manufacturers are:' )
                for item in removed_items_list:
                    self.stdout.write('- ' + item)
            else:
                self.stdout.write('Νo manufacturers were removed' )

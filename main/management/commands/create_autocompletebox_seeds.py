# Products import command via CSV file.
from collections import Counter
from django.core.management.base import BaseCommand
from main import models

from django.db.models import Q

import datetime

class Command(BaseCommand):
    help = "Creates a list with autocomplete search box (head bar) seeds."

    def add_arguments(self, parser):
        parser.add_argument('-l', '--list', action='store_true', help='Prints out the list of autocomplete search box seeds.')

    def handle(self, *args, **options):

        self.stdout.write("Creating autocomplete search box seeds")
        SeedsFile=open('utils/search_box_seeds.txt','w')

        c = Counter()
        seeds_list = []
        product_categories_qs = models.ProductCategory.objects.filter(children__isnull=True)
        manufacturers_qs = models.Manufacturer.objects.all()
        products_qs =  models.Product.objects.filter(Q(structure = 'parent') | Q(structure = 'standalone'))

        for obj in product_categories_qs:
            obj.slug = obj.slug.replace('-', ' ')
            obj.slug = obj.slug.replace('kh', 'x')
            obj.slug = obj.slug.replace('ph', 'f')
            seeds_list.append(obj.slug)
            seeds_list.append(obj.name)
            c['product_categories'] += 1

        for obj in manufacturers_qs:
            obj.slug = obj.slug.replace('-', ' ')
            seeds_list.append(obj.slug)
            seeds_list.append(obj.name)
            c['manufacturers'] += 1

        for obj in products_qs:
            obj.slug = obj.slug.replace('-', ' ')
            seeds_list.append(obj.slug)
            seeds_list.append(obj.name)
            c['products'] += 1

        SeedsFile.write('[')
        for element in seeds_list:
             SeedsFile.write(element)
             SeedsFile.write(',')
        SeedsFile.write(']')        
        SeedsFile.close()

        self.stdout.write(
            "Created Seeds:\n -%d From Product Categories\n -%d from Manufacturers\n -%d Products\n"
            % (c["product_categories"], c["manufacturers"], c["products"])
        )

        if options['list']:
            if (c["product_categories"] + c["manufacturers"] + c["products"]) > 0:
                self.stdout.write('The created seeds are:' )
                for item in seeds_list:
                    self.stdout.write('- ' + item)
            else:
                self.stdout.write('Νo seeds were created' )

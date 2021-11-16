# Products import command via CSV file.
from collections import Counter
from django.core.exceptions import ObjectDoesNotExist
import csv
import os.path
from django.core.management.base import BaseCommand
from main import models

class Command(BaseCommand):
    help = "Import customers in Distributed Mall"
    def add_arguments(self, parser):
        parser.add_argument("csvfile", type=open)

    def handle(self, *args, **options):
        c = Counter()
        reader = csv.DictReader(options.pop("csvfile"))
        self.stdout.write("Importing foo customers")

        for row in reader:
            #Exception handling in case the product category listed in csvfile
            #does not exist

            user, created = models.User.objects.get_or_create(
                email=row['email'],
                first_name=row['first_name'],
                last_name=row['last_name'],
                password = row['password'],
                is_seller = False,
                is_customer = True
            )
            c["users"] += 1
            if created:
                c["users_created"] += 1

            customer = models.Customer.objects.get_or_create(
                birth_date = row['birth_date'],
                user = user,
                gender =row['gender'],
                phone_number= row['phone_number'],
                orange_points = row['orange_points'],
            )
            c["customers"] += 1
            if created:
                c["customers_created"] += 1


        self.stdout.write(
            "Users processed=%d (created=%d)"
            % (c["users"], c["products_created"])
        )
        self.stdout.write(
            "Customers processed=%d (created=%d)"
            % (c["customers"], c["customers_created"])
        )

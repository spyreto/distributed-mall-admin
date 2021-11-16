# Products import command via CSV file.
from collections import Counter
from django.core.management.base import BaseCommand
from main import models

import datetime

class Command(BaseCommand):
    help = "Update offers."

    def handle(self, *args, **options):
        c = Counter()
        self.stdout.write("Updating products offers")
        c["offers"] = 0
        c["started"] = 0
        c["ended"] = 0

        offers = models.Offer.objects.filter(has_expired = False).exclude(start_date__isnull=True, end_date__isnull=True)
        for offer in offers:
            c["offers"] += 1
            if offer.end_date is None:
                if offer.start_date >= datetime.date.today() and offer.is_open == False:
                    offer.is_open = True
                    offer.save()
                    c["started"] += 1
            elif offer.start_date is None:
                if offer.end_date >= datetime.date.today():
                    offer.is_open = False
                    offer.has_expired = True
                    offer.save()
                    c["ended"] += 1
            else:
                if offer.start_date >= datetime.date.today() and offer.is_open == False:
                    offer.is_open = True
                    offer.save()
                    c["started"] += 1
                elif offer.end_date >= datetime.date.today() and offer.is_open == True:
                    offer.is_open = False
                    offer.has_expired = True
                    offer.save()
                    c["ended"] += 1

        self.stdout.write(
            "Offers processed = %d (Started = %d, Ended = %d)"
            % (c["offers"], c["started"] ,c["ended"])
        )

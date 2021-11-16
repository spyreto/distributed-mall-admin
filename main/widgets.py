from django.forms.widgets import Widget
from django.conf import settings

class GoogleMapApi(Widget):
    class Media:
        js = ('https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js',
            'https://maps.google.com/maps/api/js?key={}&libraries=places'.format(
                settings.GOOGLE_MAPS_API_KEY),settings.STATIC_URL + 'js/googlemapapi.js',)

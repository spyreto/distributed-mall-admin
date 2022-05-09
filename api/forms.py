from django import forms
from django.forms import ModelForm
from django.apps import apps


class SaleCreationForm(ModelForm):
    class Meta:
        model = apps.get_model('main','Sale')
        fields = ('company', 'customer', 'product',
            'quantity', 'selling_price', 'paid_with_money', )
        field_classes = {"email": UsernameField}


    def clean(self):
        paid_with_money = self.cleaned_data.get("paid_with_money")
        customer = self.cleaned_data.get("customer")
        selling_price = self.cleaned_data.get("selling_price")

        if not paid_with_money:
            user = models.Product.objects.get(id = customer)
            if user.orange_points < selling_price*200
                raise forms.ValidationError("Your points are not enough")

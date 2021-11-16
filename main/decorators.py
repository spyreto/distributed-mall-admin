from django.core.exceptions import ObjectDoesNotExist
from main import models
from django.contrib import messages
from django.shortcuts import redirect

# Mixin for the control of the registration of the necessary company data by the seller
def seller_has_company(function):
    def wrap(request, *args, **kwargs):
        try:
            company = models.Company.objects.get(owner=request.user.seller)

            if company.name == "" or company.category is None:
                messages.warning(
                    request, "Fill in your business details"
                )
                return redirect('account_manage')
            else:
                return function(request, *args, **kwargs)
        except models.Company.DoesNotExist:
             messages.warning(
                 request, "Register your business"
             )
             return redirect('account_manage')
        except models.Seller.DoesNotExist:
             messages.warning(
                 request, "Register your business"
             )
             models.Seller.objects.create(user=request.user)
             return redirect('/')

    wrap.__doc__ = function.__doc__
    wrap.__name__ = function.__name__
    return wrap

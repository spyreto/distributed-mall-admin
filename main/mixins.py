from django.shortcuts import redirect

from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin

from django.core.exceptions import ObjectDoesNotExist
from main import  models

# Mixin for the control of the registration of the necessary company data by the seller
class UserHasCompanyMixin(LoginRequiredMixin):
     def dispatch(self, request, *args, **kwargs):
        try:
            company = models.Company.objects.get(owner=request.user.seller)

            if company.name == "" or company.category is None:
                messages.warning(
                    self.request, "Fill in your business details"
                )
                return redirect('account_manage')
            else:
                return super().dispatch(request, *args, **kwargs)
        except models.Company.DoesNotExist:
             messages.warning(
                 self.request, "Register your business"
             )
             return redirect('account_manage')

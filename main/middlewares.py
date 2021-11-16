from . import models

def company_middleware(get_response):
    def middleware(request):
        if 'company_id' in request.session:
            company_id = request.session['company_id']
            company = models.Company.objects.get(id=company_id)
            request.company = company
        else:
            request.company=None
        response = get_response(request)
        return response
    return middleware

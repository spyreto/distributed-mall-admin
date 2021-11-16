from django.urls import path
from django.views.generic import TemplateView
from django.views.generic.detail import DetailView
from django.contrib.auth import views as auth_views
from main import views, models, forms


urlpatterns = [
    path('', views.home,
        name ="home",
    ),

    path('login/',
        auth_views.LoginView.as_view(
            template_name="login.html",
            form_class=forms.AuthenticationForm,
        ),
        name="login",
    ),

    path('logout/',
        views.logoutView,
        name="logout",
    ),

    path('signup/',
        views.SellerSignupView.as_view(),
        name="signup"
    ),

    path('account-management/',
            views.account_manage,
            name="account_manage",
    ),

    path("password-change/",
            views.PasswordChangeView.as_view(),
            name="password_change",
    ),

    path("about-us/",
        TemplateView.as_view(template_name="about_us.html"),
        name ="about_us",
    ),

    path("contact-us/",
        views.contact_us_view,
        name="contact_us",
    ),

    path("product/",
        views.ProductListView.as_view(),
        name="product_list",
    ),

    path("search-results/<str:keyword>/",
        views.search_results,
        name="search_results",
    ),
    path("product-manage/<int:pk>/<int:category_type>/",
      views.product_manage,
      name="product_manage",
      ),

    path(
       "product/<int:pk>/delete/",
       views.ProductDeleteView.as_view(),
       name="product_delete",
    ),

    path('select-product-category/',
        views.select_product_category,
        name="select_product_category",
    ),

    path('<int:category_id>/select-product/',
        views.select_product,
        name="select_product",
    ),

    path('add-product/',
        views.add_product,
        name='add_product',
    ),
    path('product-processing/<int:pk>/',
        views.product_processing,
        name='product_processing',
    ),
    path(
       "product/<int:pk>/details/",
       views.ProductDetailView.as_view(),
       name="product_details",
    ),
    path('offers-list/',
        views.offers_list,
        name="offers_list",
    ),

    path('offer-details/<int:pk>/',
        views.OfferDetailView.as_view(),
        name="offer_details",
    ),

    path('sales-list/',
        views.sales_list,
        name="sales_list",
    ),

    path('sale-details/<str:prv_pg>/<int:pk>/',
        views.sale_details,
        name="sale_details",
    ),

    path('charts',
        views.charts_view,
        name="charts",
    ),

    path("under-construction/",
        TemplateView.as_view(template_name="under_construction.html"),
        name ="under_construction",
    ),
]

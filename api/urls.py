from django.conf.urls.i18n import i18n_patterns
from django.urls import path
from rest_framework.authtoken import views as authtoken_views
from api import views



urlpatterns = [
    path(
        "auth/",
        views.AuthToken.as_view(),
        name="auth",
    ),
    path(
        "sign-up/",
        views.RegistrationView.as_view(),
        name="sign_up",
    ),
    path(
        "get-user-info/",
        views.GetUserInfo.as_view(),
        name="get_user_info",
    ),
    path(
        "change-info/<int:pk>/",
        views.ChangeInfo.as_view(),
        name="change_info",
    ),
    path("password-change/<int:pk>/",
        views.ChangePasswordView.as_view(),
        name="password_change",
    ),

    path("remove-favorite/<int:pk>/",
        views.RemoveFavoriteView.as_view(),
        name="remove_favorite",
    ),

    path("add-favorite/<int:pk>/",
        views.AddFavoriteView.as_view(),
        name="add_favorite",
    ),

    path('product-categories/',
        views.ProductsCategoriesView.as_view(),
        name ="product_categories",
    ),
    path('search-products/<str:keyword>/',
        views.SearchProductsView.as_view(),
        name ="search_products_api",
    ),
    path('product/<int:pk>/',
        views.ProductView.as_view(),
        name ="product_api",
    ),
    path('product-details/<int:pk>/<int:category_type>/',
        views.ProductsDetailsView.as_view(),
        name ="product_details_api",
    ),
    path('search-products/<str:keyword>/<int:product_category>/',
        views.SearchProductsView.as_view(),
        name ="search_products_api",
    ),
    path('available-sizes/<int:product_id>/<int:category_type>/<int:seller_id>/',
        views.AvailableSizes.as_view(),
        name ="available_sizes_api",
    ),
    path('offers/',
        views.OffersView.as_view(),
        name ="offers_api",
    ),
    path('product-reservation/<int:product_id>/<int:filters>/',
        views.product_reservation,
        name ="product_reservation",
    ),
    path('product-reservation/<int:product_id>/<str:filters>/',
        views.product_reservation,
        name ="product_reservation",
    ),

]

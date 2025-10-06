from django.urls import path

import auth_system.views

urlpatterns = [
    path("register/", 
         auth_system.views.UserRegistrationView.as_view(),
         name="register"),
    path("login/",
         auth_system.views.UserLoginView.as_view(),
         name="login"),
]

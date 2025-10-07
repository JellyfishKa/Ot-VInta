from django.urls import path

import api.views

urlpatterns = [
    path('services/',
         api.views.ServicesListView.as_view(),
         name='services-list'),
    path('benefits/',
         api.views.BenefitListView.as_view(),
         name='benefits-list'),
    path('requests/',
         api.views.RequestListCreateView.as_view(),
         name='requests-list-create'),
    path('requests/<int:pk>/',
         api.views.RequestDetailView.as_view(),
         name='request-detail'),
    path('requests/<int:pk>/delete',
         api.views.RequestDeleteView.as_view(),
         name="request-detail-delete"),
]

from django.urls import path
from . import views

urlpatterns = [
    path('contact/', views.submit_contact_form, name='submit_contact'),
]









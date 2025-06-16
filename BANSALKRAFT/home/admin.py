# admin.py
from django.contrib import admin
from .models import ContactMessage
import csv
from django.http import HttpResponse

@admin.action(description="Export selected leads to CSV")
def export_to_csv(modeladmin, request, queryset):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="contact_leads.csv"'

    writer = csv.writer(response)
    writer.writerow(['Name', 'Email'])  # header row
    for lead in queryset:
        writer.writerow([lead.name, lead.email])

    return response

@admin.register(ContactMessage)
class ContactMessage(admin.ModelAdmin):
    list_display = ['name', 'email']
    actions = [export_to_csv]  # ✅ Attach the action

from django.core.mail import send_mail
from django.shortcuts import render
from django.conf import settings
from .models import ContactMessage

def index(request):
    
    if request.method == 'POST':
     
        name = request.POST.get('name')
        email = request.POST.get('email')
        subject = request.POST.get('subject')
        message = request.POST.get('message')

        contact = ContactMessage(
            name=name,
            email=email,
            
        )
        contact.save()

        full_message = f"New Contact Form Submission:\n\nFrom: {name} <{email}>\nSubject: {subject}\n\nMessage:\n{message}"

        send_mail(
            subject=f"Website Contact: {subject}",
            message=full_message,
            from_email=settings.EMAIL_HOST_USER,
            recipient_list=['info@bansalkrafts.com'],  # <-- Teri company ka email id yahan
            fail_silently=False,
        )
        try:
            send_mail(...)
            success = True
        except:
            success = False

        send_mail(
            'Thank you for contacting Bansal Krafts',
            f"Hi {name},\n\nThank you for contacting us. We have received your message and will get back to you shortly.\n\nRegards,\nBansal Krafts Team",
            settings.DEFAULT_FROM_EMAIL,
            [email],  # ✅ User email
            fail_silently=False,
        )

        return render(request, 'index.html' )

    return render(request, 'index.html')

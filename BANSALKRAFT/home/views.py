from django.core.mail import send_mail
from django.shortcuts import render
from django.conf import settings

def index(request):
    
    if request.method == 'POST':
     
        name = request.POST.get('name')
        email = request.POST.get('email')
        subject = request.POST.get('subject')
        message = request.POST.get('message')

        full_message = f"New Contact Form Submission:\n\nFrom: {name} <{email}>\nSubject: {subject}\n\nMessage:\n{message}"

        send_mail(
            subject=f"Website Contact: {subject}",
            message=full_message,
            from_email=settings.EMAIL_HOST_USER,
            recipient_list=['nikkityagi81@gmail.com'],  # <-- Teri company ka email id yahan
            fail_silently=False,
        )

        return render(request, 'index.html' )

    return render(request, 'index.html')

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.core.mail import send_mail
from django.conf import settings
from .models import ContactMessage
from .serializers import ContactMessageSerializer

@api_view(['POST'])
def submit_contact_form(request):
    """
    Handle contact form submission from Flutter app
    POST /api/contact/
    """
    serializer = ContactMessageSerializer(data=request.data)
    
    if serializer.is_valid():
        # Save the contact message
        contact = serializer.save()
        
        # Prepare email content
        name = contact.name
        email = contact.email
        subject = contact.subject
        message = contact.message
        
        # Email to company
        company_message = f"""New Contact Form Submission from Mobile App:

From: {name} <{email}>
Subject: {subject}

Message:
{message}

---
Submitted at: {contact.submitted_at}
"""
        
        # Email to user (confirmation)
        user_message = f"""Hi {name},

Thank you for contacting Bansal Krafts. We have received your message and will get back to you shortly.

Your Message:
Subject: {subject}
Message: {message}

Regards,
Bansal Krafts Team
"""
        
        try:
            # Send email to company
            send_mail(
                subject=f"Mobile App Contact: {subject}",
                message=company_message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=['info@bansalkrafts.com'],  # Company email
                fail_silently=False,
            )
            
            # Send confirmation email to user
            send_mail(
                subject='Thank you for contacting Bansal Krafts',
                message=user_message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=[email],
                fail_silently=False,
            )
            
            return Response(
                {
                    'success': True,
                    'message': 'Your message has been sent successfully. We will get back to you soon.'
                },
                status=status.HTTP_201_CREATED
            )
            
        except Exception as e:
            # Even if email fails, save the message
            return Response(
                {
                    'success': True,
                    'message': 'Your message has been received. We will get back to you soon.',
                    'note': 'Email notification failed, but your message was saved.'
                },
                status=status.HTTP_201_CREATED
            )
    
    return Response(
        {
            'success': False,
            'errors': serializer.errors
        },
        status=status.HTTP_400_BAD_REQUEST
    )

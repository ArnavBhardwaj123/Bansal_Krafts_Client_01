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
        
        # Send both emails - one to owner and one to user
        email_errors = []
        owner_email_sent = False
        user_email_sent = False
        
        # Email 1: Send to owner (info@bansalkrafts.com)
        try:
            send_mail(
                subject=f"Mobile App Contact: {subject}",
                message=company_message,
                from_email=settings.EMAIL_HOST_USER,  # Match website format
                recipient_list=['info@bansalkrafts.com'],  # Owner email
                fail_silently=False,
            )
            owner_email_sent = True
            print(f"✅ Owner email sent successfully to info@bansalkrafts.com")
        except Exception as e:
            email_errors.append(f"Owner email failed: {str(e)}")
            print(f"❌ Owner email failed: {str(e)}")
        
        # Email 2: Send confirmation to user (CRITICAL - user must receive this)
        try:
            # Use EMAIL_HOST_USER for both emails (same as website does for owner email)
            # This ensures consistency and proper email delivery
            from_email = settings.EMAIL_HOST_USER
            if not from_email:
                # Fallback if EMAIL_HOST_USER is not set
                from_email = settings.DEFAULT_FROM_EMAIL or 'noreply@bansalkrafts.com'
            
            print(f"📧 Attempting to send user confirmation email to: {email}")
            print(f"📧 From email: {from_email}")
            print(f"📧 Email settings - HOST_USER: {settings.EMAIL_HOST_USER}, DEFAULT_FROM: {settings.DEFAULT_FROM_EMAIL}")
            
            send_mail(
                subject='Thank you for contacting Bansal Krafts',
                message=user_message,
                from_email=from_email,  # Use EMAIL_HOST_USER (same as owner email)
                recipient_list=[email],  # User email from form
                fail_silently=False,
            )
            user_email_sent = True
            print(f"✅ User confirmation email sent successfully to {email}")
        except Exception as e:
            email_errors.append(f"User email failed: {str(e)}")
            print(f"❌ User email failed to {email}: {str(e)}")
            # Log the full error for debugging
            import traceback
            print(f"Full traceback: {traceback.format_exc()}")
        
        # Return success response (message is saved regardless of email status)
        if not user_email_sent:
            # If user email failed, this is critical - log it but still return success
            print(f"⚠️ WARNING: User confirmation email was NOT sent to {email}")
            return Response(
                {
                    'success': True,
                    'message': 'Your message has been received. We will get back to you soon.',
                    'note': 'Confirmation email could not be sent. Please check your email address.',
                    'email_sent': False
                },
                status=status.HTTP_201_CREATED
            )
        elif email_errors:
            # Owner email failed but user email sent - still success
            return Response(
                {
                    'success': True,
                    'message': 'Your message has been sent successfully. Check your email for confirmation.',
                    'note': 'Your confirmation email has been sent.',
                    'email_sent': True
                },
                status=status.HTTP_201_CREATED
            )
        else:
            # Both emails sent successfully
            return Response(
                {
                    'success': True,
                    'message': 'Your message has been sent successfully. Check your email for confirmation.',
                    'email_sent': True
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

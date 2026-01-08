from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny
from django.conf import settings
from django.core.mail import send_mail, EmailMessage
from django.views.decorators.csrf import csrf_exempt
import logging

logger = logging.getLogger(__name__)


@api_view(['POST'])
@permission_classes([AllowAny])
@csrf_exempt
def submit_contact_form(request):
    # Log incoming request for debugging
    logger.info(f"Received contact form request. Method: {request.method}")
    logger.info(f"Request data: {request.data}")
    logger.info(f"Request body: {request.body}")
    
    # Try to get data from request.data (DRF) or request.POST (Django)
    try:
        if hasattr(request, 'data'):
            name = request.data.get("name", "").strip()
            email = request.data.get("email", "").strip()
            subject = request.data.get("subject", "").strip()
            message = request.data.get("message", "").strip()
        else:
            # Fallback to POST data
            name = request.POST.get("name", "").strip()
            email = request.POST.get("email", "").strip()
            subject = request.POST.get("subject", "").strip()
            message = request.POST.get("message", "").strip()
    except Exception as e:
        logger.error(f"Error parsing request data: {e}")
        return Response(
            {"error": "Invalid request format", "details": str(e)},
            status=status.HTTP_400_BAD_REQUEST
        )

    # Validate required fields
    if not name or not email or not subject or not message:
        missing = []
        if not name: missing.append("name")
        if not email: missing.append("email")
        if not subject: missing.append("subject")
        if not message: missing.append("message")
        
        logger.warning(f"Missing required fields: {missing}")
        return Response(
            {"error": "All fields are required", "missing_fields": missing},
            status=status.HTTP_400_BAD_REQUEST
        )

    try:
        # 🔹 MAIL TO OWNER
        try:
            EmailMessage(
                subject=f"New Contact: {subject}",
                body=f"""
Name: {name}
Email: {email}

Message:
{message}
                """,
                from_email=settings.DEFAULT_FROM_EMAIL,
                to=["arnavbhardwaj439@gmail.com"],
                reply_to=[email]
            ).send(fail_silently=False)
            owner_email_sent = True
        except Exception as e:
            # Log error but don't fail the request
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Failed to send owner email: {e}")
            owner_email_sent = False

        # 🔹 MAIL TO USER (confirmation)
        try:
            send_mail(
                "Thanks for contacting Bansal Krafts",
                f"Hi {name},\n\nWe received your message and will contact you soon.\n\nTeam Bansal Krafts",
                settings.DEFAULT_FROM_EMAIL,
                [email],
                fail_silently=False
            )
            user_email_sent = True
        except Exception as e:
            # Log error but don't fail the request
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Failed to send user confirmation email: {e}")
            user_email_sent = False

        # Return success even if one email fails (better UX)
        if owner_email_sent or user_email_sent:
            return Response(
                {
                    "success": True, 
                    "message": "Contact form submitted successfully",
                    "owner_email_sent": owner_email_sent,
                    "user_email_sent": user_email_sent
                },
                status=status.HTTP_200_OK
            )
        else:
            # Both emails failed, but form was submitted
            return Response(
                {
                    "success": True,
                    "message": "Form submitted, but email delivery failed. We'll contact you soon.",
                    "warning": "Email service temporarily unavailable"
                },
                status=status.HTTP_200_OK
            )
            
    except Exception as e:
        # Unexpected error
        import logging
        logger = logging.getLogger(__name__)
        logger.error(f"Unexpected error in contact form: {e}")
        return Response(
            {"error": "An error occurred while processing your request"},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.conf import settings
from django.core.mail import send_mail, EmailMessage


@api_view(['POST'])
def submit_contact_form(request):
    name = request.data.get("name")
    email = request.data.get("email")
    subject = request.data.get("subject")
    message = request.data.get("message")

    if not all([name, email, subject, message]):
        return Response(
            {"error": "All fields required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # 🔹 MAIL TO OWNER
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

    # 🔹 MAIL TO USER
    send_mail(
        "Thanks for contacting Bansal Krafts",
        f"Hi {name},\n\nWe received your message and will contact you soon.\n\nTeam Bansal Krafts",
        settings.DEFAULT_FROM_EMAIL,
        [email],
        fail_silently=False
    )

    return Response(
        {"success": True, "message": "Both emails sent"},
        status=status.HTTP_200_OK
    )

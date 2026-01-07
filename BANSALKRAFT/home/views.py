from django.core.mail import send_mail
from django.shortcuts import render
from django.conf import settings
from .models import ContactMessage


def index(request):
    if request.method == "POST":
        name = request.POST.get("name")
        email = request.POST.get("email")
        subject = request.POST.get("subject")
        message = request.POST.get("message")

        # Save contact message in the database
        contact = ContactMessage(
            name=name,
            email=email,
        )
        contact.save()

        full_message = (
            "New Contact Form Submission:\n\n"
            f"From: {name} <{email}>\n"
            f"Subject: {subject}\n\n"
            f"Message:\n{message}"
        )

        # Send email to site owner
        try:
            send_mail(
                subject=f"Website Contact: {subject}",
                message=full_message,
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=["info@bansalkrafts.com"],
                fail_silently=False,
            )
            success = True
        except Exception:
            success = False

        # Send confirmation email to user (do not block on admin email failure)
        send_mail(
            subject="Thank you for contacting Bansal Krafts",
            message=(
                f"Hi {name},\n\n"
                "Thank you for contacting us. We have received your message and "
                "will get back to you shortly.\n\n"
                "Regards,\nBansal Krafts Team"
            ),
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=[email],
            fail_silently=False,
        )

        return render(request, "index.html", {"success": success})

    return render(request, "index.html")

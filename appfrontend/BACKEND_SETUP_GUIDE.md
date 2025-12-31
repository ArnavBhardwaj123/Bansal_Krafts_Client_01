# Backend Setup Guide for Bansal Krafts Flutter App

This guide will help you create a Django REST API backend similar to your website backend, but optimized for the Flutter mobile app.

## 📋 Prerequisites

- Python 3.8+ installed
- pip (Python package manager)
- Basic knowledge of Django
- Your website backend as reference (BANSALKRAFT folder)

## 🚀 Step 1: Create Django Project Structure

### 1.1 Create a new Django project for the API

```bash
# Navigate to your project root (where BANSALKRAFT folder is)
cd D:\Projects\Bansal_Krafts_Client_01

# Create a new Django project for API
django-admin startproject appbackend_api

# Navigate into the project
cd appbackend_api
```

### 1.2 Create a Django app for API

```bash
python manage.py startapp api
```

## 📦 Step 2: Install Required Packages

### 2.1 Create requirements.txt

Create a file `requirements.txt` in `appbackend_api/` folder:

```txt
Django==5.2.0
djangorestframework==3.14.0
django-cors-headers==4.3.1
python-decouple==3.8
python-dotenv==1.0.0
```

### 2.2 Install packages

```bash
pip install -r requirements.txt
```

## ⚙️ Step 3: Configure Django Settings

### 3.1 Update `appbackend_api/appbackend_api/settings.py`

Add these configurations:

```python
"""
Django settings for appbackend_api project.
"""

from pathlib import Path
import os
from decouple import config
from dotenv import load_dotenv

# Build paths inside the project
BASE_DIR = Path(__file__).resolve().parent.parent

# Load environment variables
load_dotenv(BASE_DIR / '.env')

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = config('SECRET_KEY', default='your-secret-key-change-in-production')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = config('DEBUG', default=True, cast=bool)

ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='localhost,127.0.0.1', cast=lambda v: [s.strip() for s in v.split(',')])

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # Third party apps
    'rest_framework',
    'corsheaders',
    # Your apps
    'api',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',  # Add this for CORS
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'appbackend_api.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'appbackend_api.wsgi.application'

# Database
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Static files
STATIC_URL = 'static/'

# Default primary key field type
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# REST Framework Configuration
REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.AllowAny',  # Allow all for now, change in production
    ],
    'DEFAULT_RENDERER_CLASSES': [
        'rest_framework.renderers.JSONRenderer',
    ],
}

# CORS Configuration - IMPORTANT for Flutter app
CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",  # For web development
    "http://127.0.0.1:3000",
    # Add your Flutter web app URL when deployed
]

# Allow all origins in development (change in production)
CORS_ALLOW_ALL_ORIGINS = DEBUG  # Only in development

CORS_ALLOW_CREDENTIALS = True

CORS_ALLOW_METHODS = [
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
]

CORS_ALLOW_HEADERS = [
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
]

# Email Configuration (same as your website)
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER', '')
EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD', '')
DEFAULT_FROM_EMAIL = os.getenv('EMAIL_HOST_USER', 'noreply@bansalkrafts.com')
```

## 📝 Step 4: Create Models

### 4.1 Update `appbackend_api/api/models.py`

```python
from django.db import models

class ContactMessage(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    subject = models.CharField(max_length=200)
    message = models.TextField()
    submitted_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)

    class Meta:
        ordering = ['-submitted_at']
        verbose_name = 'Contact Message'
        verbose_name_plural = 'Contact Messages'

    def __str__(self):
        return f"{self.name} - {self.email} - {self.subject}"
```

### 4.2 Create and run migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

## 🔌 Step 5: Create Serializers

### 5.1 Create `appbackend_api/api/serializers.py`

```python
from rest_framework import serializers
from .models import ContactMessage

class ContactMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContactMessage
        fields = ['id', 'name', 'email', 'subject', 'message', 'submitted_at']
        read_only_fields = ['id', 'submitted_at']
```

## 🎯 Step 6: Create API Views

### 6.1 Update `appbackend_api/api/views.py`

```python
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
                recipient_list=['info@bansalkrafts.com'],  # Your company email
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
```

## 🛣️ Step 7: Create URL Routes

### 7.1 Create `appbackend_api/api/urls.py`

```python
from django.urls import path
from . import views

urlpatterns = [
    path('contact/', views.submit_contact_form, name='submit_contact'),
]
```

### 7.2 Update `appbackend_api/appbackend_api/urls.py`

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),  # API routes
]
```

## 🔐 Step 8: Environment Variables

### 8.1 Create `.env` file in `appbackend_api/` folder

```env
SECRET_KEY=your-secret-key-here-change-in-production
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Email Configuration
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password-here
```

**Note:** For Gmail, you need to:
1. Enable 2-factor authentication
2. Generate an "App Password" from Google Account settings
3. Use that app password in `EMAIL_HOST_PASSWORD`

## 🗄️ Step 9: Register Model in Admin

### 9.1 Update `appbackend_api/api/admin.py`

```python
from django.contrib import admin
from .models import ContactMessage

@admin.register(ContactMessage)
class ContactMessageAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'subject', 'submitted_at', 'is_read']
    list_filter = ['is_read', 'submitted_at']
    search_fields = ['name', 'email', 'subject', 'message']
    readonly_fields = ['submitted_at']
    date_hierarchy = 'submitted_at'
```

## 🚀 Step 10: Run the Server

### 10.1 Create superuser (optional, for admin panel)

```bash
python manage.py createsuperuser
```

### 10.2 Run development server

```bash
python manage.py runserver
```

The API will be available at: `http://localhost:8000/api/`

## 📡 Step 11: Test the API

### 11.1 Test with curl or Postman

```bash
curl -X POST http://localhost:8000/api/contact/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "subject": "Test Subject",
    "message": "This is a test message"
  }'
```

### 11.2 Expected Response

```json
{
  "success": true,
  "message": "Your message has been sent successfully. We will get back to you soon."
}
```

## 🔗 Step 12: Update Flutter App

### 12.1 Update API URL in Flutter

Open `appfrontend/lib/services/api_service.dart` and update:

```dart
static const String baseUrl = 'http://localhost:8000/api';
```

**For Android Emulator:** Use `http://10.0.2.2:8000/api`
**For iOS Simulator:** Use `http://localhost:8000/api`
**For Physical Device:** Use your computer's IP address, e.g., `http://192.168.1.100:8000/api`

## 📱 Step 13: Production Deployment

### 13.1 Important Production Settings

Before deploying, update these in `settings.py`:

```python
DEBUG = False
ALLOWED_HOSTS = ['your-domain.com', 'api.your-domain.com']

# Use environment variables for sensitive data
SECRET_KEY = config('SECRET_KEY')

# Update CORS settings
CORS_ALLOWED_ORIGINS = [
    "https://your-flutter-web-app.com",
    "https://your-domain.com",
]
CORS_ALLOW_ALL_ORIGINS = False  # Never allow all in production
```

### 13.2 Security Checklist

- [ ] Change `SECRET_KEY` to a strong random value
- [ ] Set `DEBUG = False`
- [ ] Configure proper `ALLOWED_HOSTS`
- [ ] Set up HTTPS/SSL
- [ ] Use environment variables for sensitive data
- [ ] Configure proper CORS origins
- [ ] Set up database backups
- [ ] Configure email settings properly

## 📊 Step 14: API Endpoints Summary

| Endpoint | Method | Description | Request Body |
|----------|--------|-------------|--------------|
| `/api/contact/` | POST | Submit contact form | `{name, email, subject, message}` |

## 🎯 Step 15: Testing Checklist

- [ ] API server runs without errors
- [ ] Contact form endpoint accepts POST requests
- [ ] Emails are sent successfully
- [ ] Data is saved in database
- [ ] Flutter app can connect to API
- [ ] CORS is properly configured
- [ ] Error handling works correctly

## 🐛 Troubleshooting

### Issue: CORS errors in Flutter
**Solution:** Make sure `CORS_ALLOW_ALL_ORIGINS = True` in development, or add your Flutter app's origin to `CORS_ALLOWED_ORIGINS`

### Issue: Email not sending
**Solution:** 
- Check Gmail app password is correct
- Verify `EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD` in `.env`
- Check if 2FA is enabled on Gmail account

### Issue: Flutter can't connect to API
**Solution:**
- For Android emulator: Use `10.0.2.2` instead of `localhost`
- For physical device: Use your computer's IP address
- Check firewall settings
- Verify server is running on correct port

## 📚 Additional Resources

- Django REST Framework: https://www.django-rest-framework.org/
- Django CORS Headers: https://github.com/adamchainz/django-cors-headers
- Django Email: https://docs.djangoproject.com/en/stable/topics/email/

## ✅ Final Checklist

- [ ] Django project created
- [ ] Dependencies installed
- [ ] Models created and migrated
- [ ] API views and serializers created
- [ ] URLs configured
- [ ] Environment variables set
- [ ] Email configuration working
- [ ] API tested
- [ ] Flutter app connected
- [ ] Production settings configured

---

**Your backend is now ready!** The Flutter app will be able to submit contact forms through this API, and emails will be sent just like your website backend.


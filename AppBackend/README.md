# Bansal Krafts - Flutter App Backend API

Django REST API backend for Bansal Krafts Flutter mobile app.

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Setup Environment Variables

Copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```

Edit `.env` file with your settings:
- `SECRET_KEY`: Django secret key
- `DEBUG`: True for development
- `ALLOWED_HOSTS`: Comma-separated list of allowed hosts
- `EMAIL_HOST_USER`: Your Gmail address
- `EMAIL_HOST_PASSWORD`: Gmail app password

### 3. Run Migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

### 4. Create Superuser (Optional)

```bash
python manage.py createsuperuser
```

### 5. Run Server

```bash
python manage.py runserver
```

API will be available at: `http://localhost:8000/api/`

## 📡 API Endpoints

### Contact Form
- **URL:** `POST /api/contact/`
- **Content-Type:** `application/json`
- **Body:**
  ```json
  {
    "name": "John Doe",
    "email": "john@example.com",
    "subject": "Inquiry",
    "message": "Hello, I would like to know more about your products."
  }
  ```
- **Response:**
  ```json
  {
    "success": true,
    "message": "Your message has been sent successfully. We will get back to you soon."
  }
  ```

## 🔧 Configuration

### CORS Settings
CORS is configured to allow requests from Flutter app. In development, all origins are allowed. For production, update `CORS_ALLOWED_ORIGINS` in `settings.py`.

### Email Configuration
The backend sends emails using Gmail SMTP. Make sure to:
1. Enable 2-factor authentication on your Gmail account
2. Generate an App Password from Google Account settings
3. Use that App Password in `EMAIL_HOST_PASSWORD`

## 🗄️ Database

Uses SQLite by default. For production, consider using PostgreSQL or MySQL.

## 📝 Admin Panel

Access admin panel at: `http://localhost:8000/admin/`

Login with superuser credentials to manage contact messages.

## 🔒 Production Deployment

Before deploying:
1. Set `DEBUG = False`
2. Update `SECRET_KEY` to a strong random value
3. Configure proper `ALLOWED_HOSTS`
4. Set up HTTPS/SSL
5. Update CORS settings for your domain
6. Use environment variables for sensitive data

## 🧪 Testing

Test the API endpoint:

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

## 📚 Dependencies

- Django 5.2.9
- Django REST Framework 3.14.0
- django-cors-headers 4.3.1
- python-decouple 3.8
- python-dotenv 1.0.0











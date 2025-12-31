# Backend Setup Instructions

## 📋 Step-by-Step Setup

### Step 1: Install Dependencies

```bash
cd AppBackend
pip install -r requirements.txt
```

### Step 2: Create .env File

Create a `.env` file in the `AppBackend` folder with the following content:

```env
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-gmail-app-password
```

**Important for Gmail:**
1. Enable 2-factor authentication on your Gmail account
2. Go to Google Account → Security → App passwords
3. Generate a new app password
4. Use that app password in `EMAIL_HOST_PASSWORD`

### Step 3: Run Migrations

```bash
python manage.py makemigrations
python manage.py migrate
```

### Step 4: Create Superuser (Optional - for admin panel)

```bash
python manage.py createsuperuser
```

### Step 5: Run the Server

```bash
python manage.py runserver
```

The API will be available at: `http://localhost:8000/api/`

## 🔗 Update Flutter App

After backend is running, update the API URL in Flutter app:

**File:** `appfrontend/lib/services/api_service.dart`

```dart
static const String baseUrl = 'http://localhost:8000/api';
```

**For Android Emulator:** Use `http://10.0.2.2:8000/api`
**For iOS Simulator:** Use `http://localhost:8000/api`
**For Physical Device:** Use your computer's IP address, e.g., `http://192.168.1.100:8000/api`

## ✅ Test the API

Test the contact form endpoint:

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

Expected response:
```json
{
  "success": true,
  "message": "Your message has been sent successfully. We will get back to you soon."
}
```

## 🎯 That's It!

Your backend is ready! The Flutter app can now submit contact forms through this API.




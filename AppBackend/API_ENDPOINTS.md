# API Endpoints Documentation

## 🎯 Final API Endpoint

### Contact Form Submission

**Endpoint:** `POST /api/contact/`

**Base URL:**
- Development: `http://localhost:8000/api/contact/`
- For Android Emulator: `http://10.0.2.2:8000/api/contact/`
- For iOS Simulator: `http://localhost:8000/api/contact/`
- For Physical Device: `http://YOUR_COMPUTER_IP:8000/api/contact/`

**Headers:**
```
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "subject": "Product Inquiry",
  "message": "I would like to know more about your Kraft Paper products."
}
```

**Success Response (201 Created):**
```json
{
  "success": true,
  "message": "Your message has been sent successfully. We will get back to you soon."
}
```

**Error Response (400 Bad Request):**
```json
{
  "success": false,
  "errors": {
    "email": ["Enter a valid email address."],
    "name": ["This field is required."]
  }
}
```

**Email Notification:**
- Sends email to company: `info@bansalkrafts.com`
- Sends confirmation email to user

## 📝 Example cURL Request

```bash
curl -X POST http://localhost:8000/api/contact/ \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "subject": "Test Subject",
    "message": "This is a test message from Flutter app"
  }'
```

## 🔗 Update Flutter App

In `appfrontend/lib/services/api_service.dart`, update:

```dart
static const String baseUrl = 'http://localhost:8000/api';
```

**For Android Emulator:**
```dart
static const String baseUrl = 'http://10.0.2.2:8000/api';
```

**For Physical Device (replace with your IP):**
```dart
static const String baseUrl = 'http://192.168.1.100:8000/api';
```

## ✅ Testing Checklist

- [ ] Backend server running on port 8000
- [ ] API endpoint accessible
- [ ] CORS configured correctly
- [ ] Email settings configured in .env
- [ ] Flutter app can connect to API
- [ ] Contact form submits successfully
- [ ] Emails are sent correctly




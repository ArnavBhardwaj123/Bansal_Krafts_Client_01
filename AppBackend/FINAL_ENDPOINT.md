# 🎯 Final API Endpoint

## Contact Form API

### Endpoint Details

**URL:** `POST http://localhost:8000/api/contact/`

**Full Path:** `/api/contact/`

**Method:** `POST`

**Content-Type:** `application/json`

---

## Request Format

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "subject": "Product Inquiry",
  "message": "I would like to know more about your products."
}
```

## Success Response

**Status Code:** `201 Created`

```json
{
  "success": true,
  "message": "Your message has been sent successfully. We will get back to you soon."
}
```

## Error Response

**Status Code:** `400 Bad Request`

```json
{
  "success": false,
  "errors": {
    "email": ["Enter a valid email address."],
    "name": ["This field is required."],
    "subject": ["This field is required."],
    "message": ["This field is required."]
  }
}
```

---

## 🔧 For Different Platforms

### Development (Local)
```
http://localhost:8000/api/contact/
```

### Android Emulator
```
http://10.0.2.2:8000/api/contact/
```

### iOS Simulator
```
http://localhost:8000/api/contact/
```

### Physical Device
```
http://YOUR_COMPUTER_IP:8000/api/contact/
```
(Replace YOUR_COMPUTER_IP with your computer's local IP address)

---

## 📱 Update Flutter App

**File:** `appfrontend/lib/services/api_service.dart`

```dart
class ApiService {
  // For local development
  static const String baseUrl = 'http://localhost:8000/api';
  
  // For Android Emulator - use this:
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  
  // For Physical Device - use your computer's IP:
  // static const String baseUrl = 'http://192.168.1.100:8000/api';
}
```

---

## ✅ Backend Status

- ✅ Endpoint: `/api/contact/`
- ✅ Method: POST
- ✅ CORS: Enabled
- ✅ Email: Configured
- ✅ Database: SQLite
- ✅ Admin Panel: Available at `/admin/`

**Backend is ready to use!** 🚀




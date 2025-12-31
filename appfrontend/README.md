# Bansal Krafts Flutter App

A Flutter mobile application for Bansal Krafts Pvt Ltd, a premium paper supplier company.

## Features

- **Hero Section** with image carousel
- **About Us** section with company information and statistics
- **Products** showcase with 6 different paper products
- **Request Sample** integration with Google Forms
- **Network/Mills** section with client logos and distribution partners
- **Services** section
- **Contact Form** with backend integration
- **Footer** with company information and social links

## Setup

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Copy images from the website:
   - Copy all images from `../BANSALKRAFT/static/images/` to `assets/images/`

3. Update API endpoint:
   - Open `lib/services/api_service.dart`
   - Update the `baseUrl` with your backend API URL

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── constants/       # App colors, strings, and assets
├── models/          # Data models
├── screens/         # App screens
├── services/        # API services
└── widgets/         # Reusable widgets
    ├── about_section.dart
    ├── contact_section.dart
    ├── custom_app_bar.dart
    ├── footer_section.dart
    ├── hero_section.dart
    ├── navigation_drawer.dart
    ├── network_section.dart
    ├── products_section.dart
    └── request_sample_section.dart
```

## Dependencies

- `carousel_slider`: For image slider in hero section
- `url_launcher`: For opening external links
- `google_fonts`: For Inter font family
- `http`: For API calls
- `scrollable_positioned_list`: For smooth section scrolling

## Notes

- The app uses the same color scheme and styling as the website
- All images should be placed in `assets/images/` directory
- Update the backend API URL in `lib/services/api_service.dart` before testing the contact form

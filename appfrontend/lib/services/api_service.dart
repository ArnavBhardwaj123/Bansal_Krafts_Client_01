import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Update this with your backend URL
  static const String baseUrl = 'http://your-backend-url.com/api';

  static Future<bool> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/contact/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}


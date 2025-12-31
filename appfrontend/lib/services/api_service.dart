import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for backend communication
/// 
/// Update the baseUrl with your actual backend URL before deployment
class ApiService {
  // TODO: Update this with your backend URL before deployment
  // Example: 'http://localhost:8000/api' for local development
  // Example: 'https://api.bansalkrafts.com/api' for production
  static const String baseUrl = 'http://your-backend-url.com/api';

  /// Timeout duration for API requests
  static const Duration timeoutDuration = Duration(seconds: 30);

  /// Submit contact form to backend
  /// 
  /// Returns true if successful, false otherwise
  static Future<bool> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/contact/'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': email,
              'subject': subject,
              'message': message,
            }),
          )
          .timeout(timeoutDuration);

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // Log error for debugging
        print('API Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Network error
      print('Network Error: $e');
      return false;
    } catch (e) {
      // Other errors
      print('Error submitting contact form: $e');
      return false;
    }
  }
}


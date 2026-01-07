import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API Service for backend communication
/// 
/// Update the baseUrl with your actual backend URL before deployment
class ApiService {
  // TODO: Update this with your backend URL before deployment
  // For Android Emulator: use 'http://10.0.2.2:8000/api' (10.0.2.2 is the special IP for host machine)
  // For iOS Simulator: use 'http://localhost:8000/api'
  // For Physical Device: use 'http://YOUR_COMPUTER_IP:8000/api'
  // For production: use 'https://api.bansalkrafts.com/api'
  static const String baseUrl = 'http://10.0.2.2:8000/api';  // Android Emulator

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
        // Log error for debugging without crashing UI
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Network error
      debugPrint('Network Error: $e');
      return false;
    } catch (e) {
      // Other errors
      debugPrint('Error submitting contact form: $e');
      return false;
    }
  }
}


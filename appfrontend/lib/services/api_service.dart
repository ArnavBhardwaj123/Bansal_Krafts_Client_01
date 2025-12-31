import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for backend communication
/// 
/// Update the baseUrl with your actual backend URL before deployment
class ApiService {
  // TODO: Update this with your backend URL before deployment
  // For local development with Android emulator: 'http://10.0.2.2:8000/api'
  // For local development with iOS simulator: 'http://localhost:8000/api'
  // For physical device: 'http://YOUR_COMPUTER_IP:8000/api' (e.g., 'http://192.168.1.100:8000/api')
  // For production: 'https://api.bansalkrafts.com/api'
  static const String baseUrl = 'http://10.0.2.2:8000/api';

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
        try {
          // Parse response body
          final responseData = jsonDecode(response.body);
          
          // Also check if the response indicates success
          if (responseData['success'] == true) {
            return true;
          } else {
            // Backend returned success status code but success: false
            print('API Error: Request failed - ${responseData['message'] ?? responseData['errors']}');
            return false;
          }
        } catch (e) {
          // If response is not valid JSON but status is 200/201, assume success
          print('Warning: Could not parse response as JSON, but status code indicates success');
          return true;
        }
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


import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// API Service for backend communication
/// 
/// Update the baseUrl with your actual backend URL before deployment
class ApiService {
  // 🔧 BACKEND URL - Production Server
  // Server URL: http://68.178.171.155:8001/api
  static const String baseUrl = 'http://68.178.171.155:8001/api';
  
  // Alternative: Use different URLs for debug vs release
  // static String get baseUrl => kDebugMode 
  //   ? 'http://10.0.2.2:8000/api'  // Development
  //   : 'https://your-production-api.com/api';  // Production

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
    // Use trailing slash as specified by backend endpoint
    final url = '$baseUrl/contact/';
    debugPrint('📤 Sending contact form to: $url');
    debugPrint('📤 Data: name=$name, email=$email, subject=$subject');
    
    try {
      // Prepare JSON body
      final jsonBody = jsonEncode({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
      });
      
      debugPrint('📤 Request Body: $jsonBody');
      
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonBody,
          )
          .timeout(timeoutDuration);

      debugPrint('📥 Response Status: ${response.statusCode}');
      debugPrint('📥 Response Body: ${response.body}');

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Contact form submitted successfully!');
        return true;
      } else {
        // Log error for debugging
        debugPrint('❌ API Error: ${response.statusCode}');
        debugPrint('❌ Response: ${response.body}');
        return false;
      }
    } on http.ClientException catch (e) {
      // Network error - connection reset or timeout
      debugPrint('❌ Network Error: $e');
      debugPrint('❌ This usually means:');
      debugPrint('   1. Server is not accessible from emulator');
      debugPrint('   2. Server firewall is blocking connections');
      debugPrint('   3. Server is down or not running');
      debugPrint('   4. Wrong URL or port');
      return false;
    } on Exception catch (e) {
      // Other errors
      debugPrint('❌ Error submitting contact form: $e');
      return false;
    } catch (e) {
      // Catch-all for any other errors
      debugPrint('❌ Unexpected error: $e');
      return false;
    }
  }
}


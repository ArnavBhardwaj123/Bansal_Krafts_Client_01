import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';

class RequestSampleSection extends StatelessWidget {
  const RequestSampleSection({super.key});

  Future<void> _openSampleForm() async {
    // Google Form URL from website - opens in new window
    const String googleFormUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSf3k-GH-6rmwWlzRbMm2hGSAsPrR4ditLBC-yo9sH9pGmnuiQ/viewform?usp=dialog';
    final Uri url = Uri.parse(googleFormUrl);
    
    try {
      // Try platform default first (works better on Android)
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.platformDefault,
        );
      } else {
        // Fallback: try in-app web view
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      }
    } catch (e) {
      // If platform default fails, try in-app web view
      try {
        await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } catch (e2) {
        // Last resort: try external application
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      color: AppColors.lightGray,
      child: Center(
        child: ElevatedButton(
          onPressed: _openSampleForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Request Sample',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}


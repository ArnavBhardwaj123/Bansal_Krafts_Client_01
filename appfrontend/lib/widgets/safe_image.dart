import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A safe image widget that handles errors gracefully
/// Prevents app crashes when images fail to load
class SafeImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? placeholderColor;
  final IconData placeholderIcon;

  const SafeImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholderColor,
    this.placeholderIcon = Icons.image_not_supported,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap in try-catch to prevent any crashes
    try {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          // Log error for debugging but don't crash
          debugPrint('Error loading image: $imagePath - $error');
          return _buildErrorWidget();
        },
        // Add frameBuilder to catch errors during loading
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            return _buildLoadingWidget();
          }
          // Wrap child in try-catch for additional safety
          try {
            return child;
          } catch (e) {
            debugPrint('Error rendering image frame: $imagePath - $e');
            return _buildErrorWidget();
          }
        },
      );
    } catch (e) {
      // Ultimate fallback - if anything goes wrong, show placeholder
      debugPrint('Critical error loading image: $imagePath - $e');
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? AppColors.lightGray,
      child: Icon(
        placeholderIcon,
        size: (height != null && height! < 50) ? height! * 0.5 : 50,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: width,
      height: height,
      color: placeholderColor ?? AppColors.lightGray,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}


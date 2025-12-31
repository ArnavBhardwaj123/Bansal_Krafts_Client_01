import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_assets.dart';
import 'safe_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      toolbarHeight: 80,
      title: SafeImage(
        imagePath: AppAssets.logo,
        height: 65,
        fit: BoxFit.contain,
      ),
      centerTitle: false,
      actions: [
        // Navigation items will be in a drawer for mobile
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textColor),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}


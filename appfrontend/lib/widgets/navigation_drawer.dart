import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppNavigationDrawer extends StatelessWidget {
  final Function(int) onSectionSelected;

  const AppNavigationDrawer({
    super.key,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Bansal Krafts',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Premium Paper Supplier',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            'Home',
            Icons.home,
            0,
          ),
          _buildDrawerItem(
            context,
            'About Us',
            Icons.info,
            1,
          ),
          _buildDrawerItem(
            context,
            'Our Products',
            Icons.inventory_2,
            2,
          ),
          _buildDrawerItem(
            context,
            'Request Sample',
            Icons.send,
            3,
          ),
          _buildDrawerItem(
            context,
            'Our Mills',
            Icons.business,
            4,
          ),
          _buildDrawerItem(
            context,
            'Contact Us',
            Icons.contact_mail,
            5,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    int sectionIndex,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textColor),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textColor),
      ),
      onTap: () {
        Navigator.pop(context);
        onSectionSelected(sectionIndex);
      },
    );
  }
}


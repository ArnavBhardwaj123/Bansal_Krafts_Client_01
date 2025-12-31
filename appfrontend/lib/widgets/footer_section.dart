import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      color: AppColors.secondary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
              const SizedBox(height: 40),
              const Divider(color: Colors.white24),
              const SizedBox(height: 20),
              Text(
                '© 2024 Bansal Krafts Pvt Ltd. All rights reserved.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              // Company Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.companyName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Your trusted partner for high-quality paper products since 1979.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _launchUrl(AppStrings.facebookUrl),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.facebook,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () => _launchUrl(AppStrings.linkedInUrl),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.business,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Quick Links
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Links',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFooterLink('Home', () {}),
                    _buildFooterLink('About Us', () {}),
                    _buildFooterLink('Our Products', () {}),
                    _buildFooterLink('Our Mills', () {}),
                    _buildFooterLink('Request Sample', () {}),
                    _buildFooterLink('Contact Us', () {}),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Products
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Our Products',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFooterLink('Kraft Paper', () {}),
                    _buildFooterLink('Carry Bag Kraft Paper', () {}),
                    _buildFooterLink('Duplex Board', () {}),
                    _buildFooterLink('Absorbent Kraft', () {}),
                    _buildFooterLink('Kraft Board', () {}),
                    _buildFooterLink('White Top Kraft Liner', () {}),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Contact
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFooterContactItem(
                      Icons.location_on,
                      'D-10/22,\nSECTOR 8 ROHINI,\nDELHI-110085\nINDIA',
                    ),
                    const SizedBox(height: 10),
                    _buildFooterContactItem(
                      Icons.phone,
                      '${AppStrings.phone1}\n${AppStrings.phone2}',
                    ),
                    const SizedBox(height: 10),
                    _buildFooterContactItem(
                      Icons.email,
                      AppStrings.email,
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.companyName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Your trusted partner for high-quality paper products since 1979.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () => _launchUrl(AppStrings.facebookUrl),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.facebook,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () => _launchUrl(AppStrings.linkedInUrl),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.business,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Quick Links
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Links',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            _buildFooterLink('Home', () {}),
            _buildFooterLink('About Us', () {}),
            _buildFooterLink('Our Products', () {}),
            _buildFooterLink('Our Mills', () {}),
            _buildFooterLink('Request Sample', () {}),
            _buildFooterLink('Contact Us', () {}),
          ],
        ),
        const SizedBox(height: 30),
        // Products
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            _buildFooterLink('Kraft Paper', () {}),
            _buildFooterLink('Carry Bag Kraft Paper', () {}),
            _buildFooterLink('Duplex Board', () {}),
            _buildFooterLink('Absorbent Kraft', () {}),
            _buildFooterLink('Kraft Board', () {}),
            _buildFooterLink('White Top Kraft Liner', () {}),
          ],
        ),
        const SizedBox(height: 30),
        // Contact
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            _buildFooterContactItem(
              Icons.location_on,
              'D-10/22,\nSECTOR 8 ROHINI,\nDELHI-110085\nINDIA',
            ),
            const SizedBox(height: 10),
            _buildFooterContactItem(
              Icons.phone,
              '${AppStrings.phone1}\n${AppStrings.phone2}',
            ),
            const SizedBox(height: 10),
            _buildFooterContactItem(
              Icons.email,
              AppStrings.email,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterContactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 16, color: AppColors.white.withOpacity(0.8)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}


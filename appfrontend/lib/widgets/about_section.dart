import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'About Bansal Krafts',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 80,
            height: 3,
            color: AppColors.primary,
          ),
          const SizedBox(height: 60),
          // About Cards
          Column(
            children: [
              _buildAboutCard(
                'Our Legacy',
                'Established in 1979, Bansal Krafts has grown to become one of India\'s most trusted paper suppliers. Our commitment to quality, reliability, and customer satisfaction has made us the preferred choice for businesses across multiple industries.',
              ),
              const SizedBox(height: 30),
              _buildAboutCard(
                'Our Commitment',
                'We are dedicated to providing our clients with the highest quality paper products, competitive pricing, and exceptional service. Our extensive network and strong relationships with leading paper mills enable us to offer the best solutions for your packaging and paper needs.',
              ),
            ],
          ),
          const SizedBox(height: 50),
          // Stats Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid layout
                if (constraints.maxWidth < 600) {
                  // Mobile: 2 columns
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildStatItem('40+', 'Years of Excellence'),
                          ),
                          Expanded(
                            child: _buildStatItem('500+', 'Satisfied Clients'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildStatItem('10+', 'States Covered'),
                          ),
                          Expanded(
                            child: _buildStatItem('15+', 'Paper Varieties'),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // Desktop: 4 columns
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildStatItem('40+', 'Years of Excellence'),
                      ),
                      Expanded(
                        child: _buildStatItem('500+', 'Satisfied Clients'),
                      ),
                      Expanded(
                        child: _buildStatItem('10+', 'States Covered'),
                      ),
                      Expanded(
                        child: _buildStatItem('15+', 'Paper Varieties'),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}


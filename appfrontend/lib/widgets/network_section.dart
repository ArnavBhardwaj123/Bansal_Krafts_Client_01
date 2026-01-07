import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_assets.dart';
import '../models/distribution_partner.dart';
import 'hover_card.dart';
import 'safe_image.dart';

class NetworkSection extends StatefulWidget {
  const NetworkSection({super.key});

  @override
  State<NetworkSection> createState() => _NetworkSectionState();
}

class _NetworkSectionState extends State<NetworkSection> {
  final List<DistributionPartner> _partners = [
    DistributionPartner(
      state: 'Rajasthan',
      partners: [
        'AGRODAYA PRODUCTS PVT LTD',
        'DYNAMIC FINE PAPER MILL PVT LTD',
        'NVESONS PAPER MILL',
        'SRB PAPERTECH PVT LTD',
        'WESTERN KRAFT & PAPER PVT LTD',
      ],
    ),
    DistributionPartner(
      state: 'Gujarat',
      partners: [
        'A-TEN PAPER MILL',
        'APOLLO PAPERS LLP',
        'GLOBAL PAPER INDUSTRIES PVT LTD',
        'HARSIDDH PAPER LTD',
        'MAHADEV CRAFT & PAPERS PVT LTD',
        'NIONI PAPER MILL',
        'PARAM KRAFT PAPER PVT LTD',
      ],
    ),
    DistributionPartner(
      state: 'Uttar Pradesh',
      partners: [
        'AGARWAL DUPLEX LIMITED',
        'ANAND DUPLEX LIMITED',
        'BHOLA RAM PAPERS & POWER PVT LTD',
        'CHADHA PAPERS LIMITED',
        'DEV PRIYA PRODUCTS PVT LTD',
        'GENUS PAPER AND BOARDS LTD',
        'HANUMANT PAPER MILLS PVT LTD',
        'MARUTI PAPERS PVT LTD',
        'SARDHANA PAPER MILLS',
        'SHREE BHAGESHWARI PAPERS PVT LTD',
        'SIDDHESHWARI INDUSTRIES PVT LTD',
        'SILVERTOAN PAPERS LIMITED',
        'SILVERTON PULP AND PAPERS PVT LTD',
      ],
    ),
    DistributionPartner(
      state: 'Himachal Pradesh, Haryana & Punjab',
      partners: [
        'GLOBE PANEL INDUSTRIES PVT LTD',
        'HRA PAPER MILLS PVT LTD',
        'RUCHIRA PAPERS LTD',
        'SATKAR PAPER MILLS PVT LTD',
        'VISHAL PAPERTECH INDIA PVT LTD',
      ],
    ),
    DistributionPartner(
      state: 'Uttarakhand',
      partners: [
        'DEVRISHI PAPERS PVT LTD',
        'GANGOTRI PAPER MILLS PVT LTD',
        'KM PAPERS',
        'SHUKLAMBARA PAPERS PVT LTD',
        'SAGAR PAPER MILLS PVT LTD',
        'UTTRANCHAL PULP AND PAPER MILLS PVT LTD',
        'VISHWANATH PAPER AND BOARDS PVT LTD',
      ],
    ),
  ];

  final Map<String, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    for (var partner in _partners) {
      _expandedStates[partner.state] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      color: AppColors.lightGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Our Network',
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
          const SizedBox(height: 40),
          _buildClientLogosSection(),
          const SizedBox(height: 60),
          _buildDistributionPartnersSection(),
          const SizedBox(height: 60),
          _buildServicesSection(),
        ],
      ),
    );
  }

  // ---------------- CLIENT LOGOS ----------------
  Widget _buildClientLogosSection() {
    final clientLogos = [
      {'name': 'DJS PRINTERS PVT LTD', 'image': AppAssets.djsLogo},
      {'name': 'VARUN BEVERAGES LTD', 'image': AppAssets.vbLogo},
      {'name': 'RAJA UDYOG PVT LTD', 'image': AppAssets.rajaLogo},
      {'name': 'MAYUR GROUP', 'image': AppAssets.mayurLogo},
      {'name': 'GALAXY OFFSET INDIA PVT LTD', 'image': AppAssets.galaxyLogo},
      {'name': 'KUMAR PRINTERS PVT LTD', 'image': AppAssets.kumarLogo},
      {'name': 'PARKSONS PACKAGING LTD', 'image': AppAssets.parksonsLogo},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Clients',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: clientLogos.length,
            itemBuilder: (context, index) {
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SafeImage(
                          imagePath: clientLogos[index]['image'] as String,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      clientLogos[index]['name'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- DISTRIBUTION PARTNERS ----------------
  Widget _buildDistributionPartnersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Distribution Partners',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Strong presence across multiple states in India',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: SafeImage(imagePath: AppAssets.indianMap),
        ),
        ..._partners.map(_buildStateAccordion),
      ],
    );
  }

  Widget _buildStateAccordion(DistributionPartner partner) {
    final isExpanded = _expandedStates[partner.state] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedStates[partner.state] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    partner.state,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.lightGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: partner.partners
                    .map(
                      (name) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '• $name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  // ---------------- SERVICES ----------------
  Widget _buildServicesSection() {
    final services = [
      {
        'title': 'Bulk Supply',
        'description':
            'Efficient bulk paper supply with flexible ordering options and competitive pricing for large-scale requirements.',
        'icon': Icons.inventory,
      },
      {
        'title': 'Quality Assurance',
        'description':
            'Rigorous quality testing and certification to ensure all paper products meet industry standards.',
        'icon': Icons.verified,
      },
      {
        'title': 'Custom Solutions',
        'description':
            'Tailored paper solutions to meet your specific business requirements.',
        'icon': Icons.build,
      },
      {
        'title': 'Just-in-Time Delivery',
        'description':
            'Reliable and timely delivery services to ensure your production schedules are maintained without interruption.',
        'icon': Icons.local_shipping,
      },
      {
        'title': 'End-to-End Solutions',
        'description':
            'A holistic approach to paper solutions tailored to your needs.',
        'icon': Icons.work,
      },
      {
        'title': 'Best Price Guaranteed',
        'description':
            'Competitive pricing with best-value assurance.',
        'icon': Icons.attach_money,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
            constraints.maxWidth > 1024 ? 3 : constraints.maxWidth > 768 ? 2 : 1;

        final aspectRatio =
            constraints.maxWidth > 1024 ? 0.7 : constraints.maxWidth > 768 ? 0.65 : 0.6;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: aspectRatio,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildServiceCard(services[index]);
          },
        );
      },
    );
  }

  // ---------------- FIXED SERVICE CARD ----------------
  Widget _buildServiceCard(Map<String, dynamic> service) {
    return HoverCard(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                service['icon'] as IconData,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              service['title'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Text(
              service['description'] as String,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

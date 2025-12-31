import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_assets.dart';
import '../models/product.dart';
import 'hover_card.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  static final List<Product> _products = [
    Product(
      name: 'Kraft Paper',
      description: 'Durable and eco-friendly, Kraft Paper is made from high-strength virgin or recycled pulp. Its natural brown finish and excellent tear resistance make it ideal for packaging, wrapping, and industrial use. A sustainable choice for businesses that value strength and simplicity.',
      imagePath: AppAssets.kraftPaper,
    ),
    Product(
      name: 'Carry Bag Kraft Paper',
      description: 'Designed for strength and sustainability, Carry Bag Kraft Paper is perfect for retail and grocery bags. With high burst factor and smooth finish, it supports printing and branding while being 100% recyclable. Ideal for stylish, sturdy, and eco-conscious packaging.',
      imagePath: AppAssets.carryBagPaper,
    ),
    Product(
      name: 'Duplex Board',
      description: 'Duplex Board is a multi-layered paperboard with a smooth white surface on one side and a grey/white or recycled base on the other. Known for its rigidity and printability, it\'s widely used in packaging boxes, cartons, and display materials. A cost-effective solution for premium packaging.',
      imagePath: AppAssets.duplexBoard,
    ),
    Product(
      name: 'Absorbent Kraft',
      description: 'Absorbent Kraft Paper is engineered for high porosity and resin absorption, making it essential in decorative laminates and industrial applications. Manufactured from virgin or agro-based pulp, it offers uniform thickness and excellent wet strength. A reliable base for lamination and coating.',
      imagePath: AppAssets.absorbentKraft,
    ),
    Product(
      name: 'Kraft Board',
      description: 'Kraft Board is a high-grammage, moisture-resistant paperboard built for heavy-duty packaging. With superior strength and structural integrity, it\'s ideal for corrugated boxes, partitions, and industrial containers. A rugged performer in demanding environments.',
      imagePath: AppAssets.kraftBoard,
    ),
    Product(
      name: 'White Top Kraft Liner',
      description: 'White Top Kraft Liner is a premium two-ply liner with a white printable surface and a strong kraft base. It offers excellent printability, stiffness, and strength—perfect for high-end corrugated packaging. Ideal for branding, shelf appeal, and structural performance.',
      imagePath: AppAssets.whiteTopKraftLiner,
    ),
  ];

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
            'Our Products',
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
          const SizedBox(height: 20),
          const Text(
            'Premium quality paper products for all your business needs',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1024 ? 3 : 
                                   constraints.maxWidth > 768 ? 2 : 1;
              // Fixed aspect ratio for consistent card sizing
              final aspectRatio = constraints.maxWidth > 1024 ? 0.68 : 
                                 constraints.maxWidth > 768 ? 0.63 : 0.58;
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(_products[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return HoverCard(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: AppColors.lightGray,
            ),
              child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightGray,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_assets.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/navigation_drawer.dart' show AppNavigationDrawer;
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/products_section.dart';
import '../widgets/request_sample_section.dart';
import '../widgets/network_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showStickyHeader = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _onScroll() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      // Find the first visible item
      final visiblePositions = positions.where((position) => position.itemTrailingEdge > 0);
      if (visiblePositions.isNotEmpty) {
        // Check if hero section (index 0) is still visible
        final heroPosition = positions.firstWhere(
          (position) => position.index == 0,
          orElse: () => positions.first,
        );
        
        // Show sticky header only when hero section is scrolled out of view
        // Check if hero section's trailing edge is less than 0 (completely scrolled past)
        final shouldShowSticky = heroPosition.itemTrailingEdge <= 0;
        
        setState(() {
          _showStickyHeader = shouldShowSticky;
        });
      } else {
        setState(() {
          _showStickyHeader = false;
        });
      }
    } else {
      setState(() {
        _showStickyHeader = false;
      });
    }
  }

  void _scrollToSection(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: AppDimensions.scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightGray,
      // Hide AppBar when sticky header is showing to prevent double navbar
      appBar: _showStickyHeader ? null : PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: const CustomAppBar(),
      ),
      endDrawer: AppNavigationDrawer(
        onSectionSelected: (index) {
          _scrollToSection(index);
        },
      ),
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemPositionsListener: _itemPositionsListener,
            itemCount: 7,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HeroSection(
                    onGetQuote: () => _scrollToSection(5),
                    onViewProducts: () => _scrollToSection(2),
                  );
                case 1:
                  return const AboutSection();
                case 2:
                  return const ProductsSection();
                case 3:
                  return const RequestSampleSection();
                case 4:
                  return const NetworkSection();
                case 5:
                  return const ContactSection();
                case 6:
                  return const FooterSection();
                default:
                  return const SizedBox();
              }
            },
          ),
          
          // Sticky Header
          if (_showStickyHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: AppDimensions.stickyHeaderDuration,
                height: AppDimensions.stickyHeaderHeight,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Hide navigation on small screens, show menu button
                    if (constraints.maxWidth < 768) {
                      return Row(
                        children: [
                          const SizedBox(width: AppDimensions.paddingMedium),
                          Image.asset(
                            AppAssets.logo,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.menu, color: AppColors.textColor),
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                          ),
                          const SizedBox(width: AppDimensions.paddingMedium),
                        ],
                      );
                    }
                    // Desktop layout with proper constraints
                    return Row(
                      children: [
                        const SizedBox(width: AppDimensions.paddingMedium),
                        Image.asset(
                          AppAssets.logo,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () => _scrollToSection(0),
                                child: const Text('Home', style: TextStyle(color: AppColors.textColor)),
                              ),
                              TextButton(
                                onPressed: () => _scrollToSection(1),
                                child: const Text('About', style: TextStyle(color: AppColors.textColor)),
                              ),
                              TextButton(
                                onPressed: () => _scrollToSection(2),
                                child: const Text('Products', style: TextStyle(color: AppColors.textColor)),
                              ),
                              TextButton(
                                onPressed: () => _scrollToSection(4),
                                child: const Text('Network', style: TextStyle(color: AppColors.textColor)),
                              ),
                              TextButton(
                                onPressed: () => _scrollToSection(5),
                                child: const Text('Contact', style: TextStyle(color: AppColors.textColor)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingMedium),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

}


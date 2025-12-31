import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
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
      final firstVisibleIndex = positions
          .where((position) => position.itemTrailingEdge > 0)
          .reduce((min, position) => position.index < min.index ? position : min)
          .index;
      
      setState(() {
        _showStickyHeader = firstVisibleIndex > 0;
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
      appBar: PreferredSize(
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
                child: Row(
                  children: [
                    const SizedBox(width: AppDimensions.paddingMedium),
                    Image.asset(
                      'assets/images/logo.png', // Update with your logo path
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
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
                    const SizedBox(width: AppDimensions.paddingMedium),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

}


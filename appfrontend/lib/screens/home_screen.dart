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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _scrollToSection(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: AppDimensions.scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightGray,
      // Always show the big CustomAppBar (user wants to keep this one)
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
          
          // Sticky Header removed - keeping only the big CustomAppBar
        ],
      ),
    );
  }

}


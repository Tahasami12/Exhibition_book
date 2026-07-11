import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:exhibition_book/core/widgets/language_toggle_button.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final isTablet = Responsive.isTablet(context) || Responsive.isDesktop(context);

    final titles = [t.onBoardingTitle1, t.onBoardingTitle2, t.onBoardingTitle3];
    final descriptions = [t.onBoardingDesc1, t.onBoardingDesc2, t.onBoardingDesc3];
    final buttons = [t.continueBtn, t.getStarted, t.getStarted];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 1000 : double.infinity,
            ),
            child: isTablet
                ? _buildTabletLayout(t, titles, descriptions, buttons)
                : _buildMobileLayout(t, titles, descriptions, buttons),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(AppStrings t, List<String> titles,
      List<String> descriptions, List<String> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: Responsive.responsiveSpacing(context, 12)),
          _buildTopBar(t),
          Expanded(
            flex: 8,
            child: _buildImage(),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 20)),
          _buildContent(titles, descriptions),
          SizedBox(height: Responsive.responsiveSpacing(context, 15)),
          _buildIndicators(),
          const Spacer(),
          _buildButton(buttons),
          SizedBox(height: Responsive.responsiveSpacing(context, 40)),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(AppStrings t, List<String> titles,
      List<String> descriptions, List<String> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          _buildTopBar(t),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: _buildImage(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildContent(titles, descriptions),
                      const SizedBox(height: 30),
                      _buildIndicators(),
                      const SizedBox(height: 50),
                      _buildButton(buttons, isTablet: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(AppStrings t) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LanguageToggleIconButton(color: kPrimaryColor),
        TextButton(
          onPressed: () async {
            await CacheHelper.setOnboardingSeen();
            if (mounted) context.go('/login');
          },
          child: Text(
            t.skip,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Image.asset(
        picture[_currentIndex],
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildContent(List<String> titles, List<String> descriptions) {
    final isTablet = Responsive.isTablet(context);
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            titles[_currentIndex],
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w700,
              fontSize: isTablet ? 32 : 26,
              letterSpacing: -1.0,
              color: Colors.grey[900],
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            descriptions[_currentIndex],
            style: GoogleFonts.roboto(
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        picture.length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == i ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentIndex == i ? kPrimaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(List<String> buttons, {bool isTablet = false}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isTablet ? 350 : double.infinity),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (_currentIndex < picture.length - 1) {
              _fadeController.reverse().then((_) {
                if (!mounted) return;
                setState(() {
                  _currentIndex++;
                });
                _fadeController.forward();
              });
            } else {
              await CacheHelper.setOnboardingSeen();
              if (mounted) context.go('/login');
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            buttons[_currentIndex],
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: .3,
            ),
          ),
        ),
      ),
    );
  }
}

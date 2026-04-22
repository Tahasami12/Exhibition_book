import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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

    final titles = [t.onBoardingTitle1, t.onBoardingTitle2, t.onBoardingTitle3];

    final descriptions = [
      t.onBoardingDesc1,
      t.onBoardingDesc2,
      t.onBoardingDesc3,
    ];

    final buttons = [t.continueBtn, t.getStarted, t.getStarted];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // ── Skip Button ──
              SizedBox(height: Responsive.responsiveSpacing(context, 12)),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    await CacheHelper.setOnboardingSeen();
                    if (context.mounted) context.go('/login');
                  },
                  child: Text(
                    t.skip,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.responsiveFontSize(context, 16),
                      height: 1.4,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),

              // ── Main Image ──
              Expanded(
                flex: 8,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    picture[_currentIndex],
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: Responsive.responsiveSpacing(context, 20)),

              // ── Title ──
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  titles[_currentIndex],
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveFontSize(context, 26),
                    letterSpacing: -1.0,
                    color: Colors.grey[900],
                    height: 1.35,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: Responsive.responsiveSpacing(context, 10)),

              // ── Description ──
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  descriptions[_currentIndex],
                  style: GoogleFonts.roboto(
                    fontSize: Responsive.responsiveFontSize(context, 17),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: Responsive.responsiveSpacing(context, 15)),

              // ── Dot Indicators ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  picture.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == i ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == i ? kPrimaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // ── Get Started Button ──
              SizedBox(
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
                      if (context.mounted) context.go('/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                      fontSize: Responsive.responsiveFontSize(context, 16),
                      height: 1.5,
                      letterSpacing: .3,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Responsive.responsiveSpacing(context, 40)),
            ],
          ),
        ),
      ),
    );
  }
}

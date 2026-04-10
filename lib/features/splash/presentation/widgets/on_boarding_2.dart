import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.responsiveSpacing(context, 24)),
              const SkipButton(),
              SizedBox(height: Responsive.responsiveSpacing(context, 13)),
              const Images(),
              SizedBox(height: Responsive.responsiveSpacing(context, 14)),
              const Text1(),
              SizedBox(height: Responsive.responsiveSpacing(context, 32)),
              const TwoButtons(),
              SizedBox(height: Responsive.responsiveSpacing(context, 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: TextButton(
          onPressed: () {
            context.go('/login');
          },
          child: Text(
            "Skip",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.responsiveFontSize(context, 18),
              height: 1.4,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Image.asset("assets/images/Frame_2.png"),
    );
  }
}

class Text1 extends StatelessWidget {
  const Text1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Your Bookish Soulmate\nAwaits",
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveFontSize(context, 26),
              letterSpacing: -1.2,
              color: Colors.grey[900],
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 15)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Let us be your guide to the perfect read.\nDiscover books tailored to your tastes\nfor a truly rewarding experience.",
            style: GoogleFonts.roboto(
              fontSize: Responsive.responsiveFontSize(context, 18),
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
              color: Colors.grey[500],
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 28)),
        Image.asset(AssetData.second),
      ],
    );
  }
}

class TwoButtons extends StatelessWidget {
  const TwoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(
            onPressed: () {
              context.go('/onboarding3');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Get started",
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Responsive.responsiveFontSize(context, 18),
                height: 1.5,
                letterSpacing: .3,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(
            onPressed: () {
              context.go('/signup');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Sign in",
              style: GoogleFonts.openSans(
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: Responsive.responsiveFontSize(context, 18),
                height: 1.5,
                letterSpacing: .3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/login_screen.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/signUp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [        
          SizedBox(height: Responsive.responsiveSpacing(context, 24)),
          SkipButton(),
          SizedBox(height: Responsive.responsiveSpacing(context, 13)),
          Images(),
          SizedBox(height: Responsive.responsiveSpacing(context, 14)),
          Text1(),
          SizedBox(height: Responsive.responsiveSpacing(context, 32)),
          TwoButtons(),
          
        ],
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24),
      child: TextButton(onPressed: (){},
       child: Text("Skip",style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.responsiveFontSize(context, 18),
                height: Responsive.responsiveSpacing(context, 1.4)
                ,color: kPrimaryColor
               ),),)
    );
  }
}

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 27,right: 28),
      child: Image.asset("assets/images/Frame_3.png"),
    );
  }
}

class Text1 extends StatelessWidget {
  const Text1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
       Container(
            padding: const EdgeInsets.only(left: 66, right: 66),

            child: Text(
               "Start Your Adventure",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.responsiveFontSize(context, 26),
                letterSpacing: -1.2,
                color: Colors.grey[900],
                height: Responsive.responsiveSpacing(context, 1.35),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 47)),
          Container(
            padding: const EdgeInsets.only(left: 65, right: 41),
            child: Text(
  "Ready to embark on a quest for \ninspiration and knowledge? Your\n adventure begins now. Let's go!",
              style: GoogleFonts.roboto(
                fontSize: Responsive.responsiveFontSize(context, 18),
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: Colors.grey[500],
                height: Responsive.responsiveSpacing(context, 1.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 28)),
          Image.asset(AssetData.third),
    ],);
  }
}


class TwoButtons extends StatelessWidget {
  const TwoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
      
        Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text("Get started", style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveFontSize(context, 18),
                    height: Responsive.responsiveSpacing(context, 1.5),
                    letterSpacing: .3)),
                ),
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 8)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: ElevatedButton(
                onPressed: () {
                  context.go('/signup');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Sign in", style:  GoogleFonts.openSans(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveFontSize(context, 18),
                    height: Responsive.responsiveSpacing(context, 1.5),
                    letterSpacing: .3)),
              ),),
      ],),
    );
  }
}
 

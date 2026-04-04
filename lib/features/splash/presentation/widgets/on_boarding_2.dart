import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/on_boarding_3.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/signUp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [        
          SizedBox(height: Responsive.responsiveSpacing(context, 60)),
          SkipButton(),
          SizedBox(height: Responsive.responsiveSpacing(context, 13)),
          Images(),
          SizedBox(height: Responsive.responsiveSpacing(context, 14)),
          Text1(),
          SizedBox(height: Responsive.responsiveSpacing(context, 38)),
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
                height: 1.4,
                color: kPrimaryColor
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
      child: Image.asset("assets/images/Frame_2.png"),
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
  "Let us be your guide to the perfect read.\n Discover books tailored to your tastes\n for a truly rewarding experience.",              style: GoogleFonts.roboto(
                fontSize: Responsive.responsiveFontSize(context, 18),
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: Colors.grey[500],
                height: Responsive.responsiveSpacing(context, 1.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
         SizedBox(height: Responsive.responsiveSpacing(context, 45)),
          Image.asset(AssetData.second),
    ],);
  }
}


class TwoButtons extends StatelessWidget {
  const TwoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: ElevatedButton(
              onPressed: () {
                Get.to(OnBoarding3());
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
                Get.to(Signup());
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
    ],);
  }
}
 

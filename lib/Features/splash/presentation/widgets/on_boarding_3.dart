import 'package:exhibition_book/Features/splash/presentation/widgets/login_screen.dart';
import 'package:exhibition_book/Features/splash/presentation/widgets/signUp.dart';
import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
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
          SizedBox(height: 60,),
          SkipButton(),
          SizedBox(height: 13,),
          Images(),
          SizedBox(height: 14,),
          Text1(),
          SizedBox(height: 32,),
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
                fontWeight: FontWeight.w500,fontSize: 18,
                height: 1.4,color: kPrimaryColor
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
                fontSize: 26,
                letterSpacing: -1.2,
                color: Colors.grey[900],
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 47),
          Container(
            padding: const EdgeInsets.only(left: 65, right: 41),
            child: Text(
  "Ready to embark on a quest for \ninspiration and knowledge? Your\n adventure begins now. Let's go!",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: Colors.grey[500],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 90),
          Image.asset(AssetData.third),
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
                Get.to(LoginScreen());
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
                  fontSize: 18,
                  height: 1.5,
                  letterSpacing: .3)),
              ),
            ),
          ),
          SizedBox(height: 8),
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
                  fontSize: 18,
                  height: 1.5,
                  letterSpacing: .3)),
            ),),
    ],);
  }
}
 

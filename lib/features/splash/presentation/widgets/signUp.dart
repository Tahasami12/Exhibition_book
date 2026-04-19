import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_router.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          Responsive.responsiveSpacing(context, 60),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: Responsive.responsiveIconSize(context, 30),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SignUpHeader(),
              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              _TextForm1(),
              SizedBox(height: Responsive.responsiveSpacing(context, 3)),
              _TextForm2(),
              SizedBox(height: Responsive.responsiveSpacing(context, 3)),
              _TextForm3(),
              SizedBox(height: Responsive.responsiveSpacing(context, 15)),
              Register(),
              SizedBox(height: Responsive.responsiveSpacing(context, 15)),
              _Line(),
              SizedBox(height: Responsive.responsiveSpacing(context, 140)),
              _SignUpFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.responsiveSpacing(context, 30)),
        Text(
          "Sign Up",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveFontSize(context, 24),
            height: Responsive.responsiveSpacing(context, 1.35),
            color: Colors.grey[900],
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 10)),
        Text(
          "Create account and choose favorite menu",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _TextForm1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, "Name"), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 20),
        fontWeight: FontWeight.w500,
        color: kGrey900,
        height: 1.4,
      ),
    ),
  );
  Widget _input1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Color(0xffFAFAFA), width: 1.5),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withValues(alpha: .03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: "Your name",
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: 1.5,
            color: Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

class _TextForm2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context,"Email"), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 20),
        fontWeight: FontWeight.w500,
        color: kGrey900,
        height: Responsive.responsiveSpacing(context, 1.4),
      ),
    ),
  );

  Widget _input1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Color(0xffFAFAFA), width: 1.5),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withValues(alpha: .03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: "Your email",
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

class _TextForm3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_labe2(context,"Password"), _input2(context)],
    );
  }

 Widget _labe2(BuildContext context, String text) => Padding(
  padding: const EdgeInsets.only(bottom: 10, left: 4),
  child: Text(
    text,
    style: GoogleFonts.roboto(
      fontSize: Responsive.responsiveFontSize(context, 20),
      fontWeight: FontWeight.w500,
      color: kGrey900,
      height: Responsive.responsiveSpacing(context, 1.4),
    ),
  ),
);
  Widget _input2(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Color(0xffFAFAFA), width: 1.5),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withValues(alpha: .03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        obscureText: true,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Your password",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.visibility_off),
          ),
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go(AppRouter.kHome);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff54408C),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: Responsive.responsiveFontSize(context, 16),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account?",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: Colors.grey[500],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // removes space
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          child: Text(
            "Sign In",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.responsiveFontSize(context, 16),
              height: Responsive.responsiveSpacing(context, 1.5),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignUpFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "By clicking Register, you agree to our ",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.responsiveFontSize(context, 16),
              height: Responsive.responsiveSpacing(context, 1.5),
              color: Colors.grey[500],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // removes space
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            child: Text(
              "Terms, Data Policy.",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.responsiveFontSize(context, 16),
                height: Responsive.responsiveSpacing(context, 1.5),
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

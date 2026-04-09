import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              _loginHeader(),
              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              _TextForm(),
              SizedBox(height: Responsive.responsiveSpacing(context, 3)),
              _TextForm2(),
              SizedBox(height: Responsive.responsiveSpacing(context, 10)),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.responsiveFontSize(context, 14),
                      height: Responsive.responsiveSpacing(context, 1.4),
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              Login(),
              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              Line(),
              SizedBox(height: Responsive.responsiveSpacing(context, 20)),
              Line2(),
              SizedBox(height: Responsive.responsiveSpacing(context, 15)),
              Final(),
              SizedBox(height: Responsive.responsiveSpacing(context, 4)),
              Final2(),
            ],
          ),
        ),
      ),
    );
  }
}

class _loginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.responsiveSpacing(context, 30)),
        Text(
          "Welcome Back 👋",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            height: 1.35,
            color: Colors.grey[900],
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Sign to your account",
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

class _TextForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, "Email"), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 4),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        fontSize: Responsive.responsiveFontSize(context, 16),
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

class _TextForm2 extends StatelessWidget {
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
        height: 1.4, 
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
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: "Your password",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.visibility_off),
          ),
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff54408C),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: Responsive.responsiveFontSize(context, 16),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account?",
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
            " Sign Up",
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

class Line2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or with",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              height: Responsive.responsiveSpacing(context, 1.4),
              fontSize: Responsive.responsiveFontSize(context, 14),
              color: Colors.grey[500],
            ),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class Final extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.responsiveSpacing(context, 50),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetData.google, width: 15),
            SizedBox(width: Responsive.responsiveSpacing(context, 10)),
            Text(
              "Sign in with Google",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: Responsive.responsiveFontSize(context, 14),
                height: Responsive.responsiveSpacing(context, 1.5),
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Final2 extends StatelessWidget {
  const Final2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.responsiveSpacing(context, 50),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.apple,
              size: Responsive.responsiveIconSize(context, 30),
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              "Sign in with Apple",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: Responsive.responsiveFontSize(context, 14),
                height: Responsive.responsiveSpacing(context, 1.5),
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:exhibition_book/core/utils/assets.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/custom_botton2.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/password_email2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

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
              onPressed: () {
                context.go('/onboarding3');
              },
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
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _loginHeader(),
                SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                TextForm(),
                SizedBox(height: Responsive.responsiveSpacing(context, 3)),
                TextForm2(),
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
                Login(formKey: _formkey),
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




class Login extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const Login({super.key, required this.formKey});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      title: "Login",
      isLoading: _isLoading,
      onTap: () async {
        if (widget.formKey.currentState!.validate()) {
          context.go(AppRouter.kHome);
        }
      },
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
          onPressed: () {
             context.go('/signup');
          },
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
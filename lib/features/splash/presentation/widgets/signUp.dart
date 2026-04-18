import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/custom_botton.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/password_email.dart';
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
  final _formKey = GlobalKey<FormState>();
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SignUpHeader(),
                SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                TextForm1(),
                SizedBox(height: Responsive.responsiveSpacing(context, 3)),
                TextForm(),
                SizedBox(height: Responsive.responsiveSpacing(context, 3)),
                TextForm2(),
                SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                Register(formKey: _formKey),
                SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                _Line(),
                SizedBox(height: Responsive.responsiveSpacing(context, 140)),
                _SignUpFooter(),
              ],
            ),
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


class Register extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const Register({super.key, required this.formKey});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      title: "Register",
      isLoading: _isLoading,
      onTap: () async {
        if (widget.formKey.currentState!.validate()) {
          context.go(AppRouter.kHome);
        }
      },
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
          onPressed: () {
            context.go('/login');
          },
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
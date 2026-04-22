import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/cubit/locale_cubit.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<LocaleCubit>().toggle();
                },
                icon: const Icon(Icons.language, color: kPrimaryColor),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if (state.role == 'admin') {
                context.go('/admin');
              } else {
                context.go(AppRouter.kHome);
              }
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            final t = AppStrings.of(context);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SignUpHeader(t: t),
                SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                _TextForm1(controller: _nameController, t: t),
                SizedBox(height: Responsive.responsiveSpacing(context, 3)),
                _TextForm2(controller: _emailController, t: t),
                SizedBox(height: Responsive.responsiveSpacing(context, 3)),
                _TextForm3(controller: _passwordController, t: t),
                SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                Register(
                  t: t,
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signUp(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                    }
                  },
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                _Line(t: t),
                SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                _SignUpFooter(t: t),
            ],
            ),
          ),
        );
      },
    ),
      ),
    );
  }
}

class _SignUpHeader extends StatelessWidget {
  final AppStrings t;
  const _SignUpHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.responsiveSpacing(context, 30)),
        Text(
          t.signUp,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveFontSize(context, 24),
            height: Responsive.responsiveSpacing(context, 1.35),
            color: Colors.grey[900],
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 10)),
        Text(
          t.signUpSubtitle,
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
  final TextEditingController controller;
  final AppStrings t;
  const _TextForm1({required this.controller, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, t.name), _input1(context)],
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
            color: Colors.grey.withOpacity(0.03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return t.nameErrorEmpty;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: t.nameHint,
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: 1.5,
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          errorStyle: const TextStyle(height: 0.8),
        ),
      ),
    );
  }
}

class _TextForm2 extends StatelessWidget {
  final TextEditingController controller;
  final AppStrings t;
  const _TextForm2({required this.controller, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context,t.email), _input1(context)],
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
            color: Colors.grey.withOpacity(0.03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return t.emailErrorEmpty;
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return t.emailErrorValid;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: t.emailHint,
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          errorStyle: const TextStyle(height: 0.8),
        ),
      ),
    );
  }
}

class _TextForm3 extends StatefulWidget {
  final TextEditingController controller;
  final AppStrings t;
  const _TextForm3({required this.controller, required this.t});

  @override
  State<_TextForm3> createState() => _TextForm3State();
}

class _TextForm3State extends State<_TextForm3> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_labe2(context,widget.t.password), _input2(context)],
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
        border: Border.all(color: const Color(0xffFAFAFA), width: 1.5),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.03),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.t.passErrorEmpty;
          }
          if (value.length < 6) {
            return widget.t.passErrorLength;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.t.passwordHint,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          hintStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          errorStyle: const TextStyle(height: 0.8),
        ),
      ),
    );
  }
}

class Register extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final AppStrings t;
  const Register({super.key, required this.onPressed, required this.t, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff54408C),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            )
          : Text(
              t.register,
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
  final AppStrings t;
  const _Line({required this.t});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.haveAccount,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: Responsive.responsiveFontSize(context, 16),
            height: Responsive.responsiveSpacing(context, 1.5),
            color: Colors.grey[500],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            context.go('/login');
          },
          child: Text(
            " ${t.signIn}",
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
  final AppStrings t;
  const _SignUpFooter({required this.t});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            t.termsPrefix,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.responsiveFontSize(context, 16),
              height: Responsive.responsiveSpacing(context, 1.5),
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            t.termsSuffix,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: Responsive.responsiveFontSize(context, 16),
              height: Responsive.responsiveSpacing(context, 1.5),
              color: kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

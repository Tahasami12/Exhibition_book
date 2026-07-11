import 'package:exhibition_book/core/utils/assets.dart';
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
import 'package:exhibition_book/core/widgets/language_toggle_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
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
          Responsive.responsiveSpacing(context, 40),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: const [
              LanguageToggleIconButton(color: kPrimaryColor),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is! AuthLoading) {
              setState(() {
                _isEmailLoading = false;
                _isGoogleLoading = false;
              });
            }
            if (state is AuthSuccess) {
              if (state.role == 'admin') {
                context.go('/admin');
              } else {
                context.go(AppRouter.kHome);
              }
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            final t = AppStrings.of(context);
            final isTablet = Responsive.isTablet(context) || Responsive.isDesktop(context);

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 700 : double.infinity,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LoginHeader(t: t),
                      SizedBox(height: Responsive.responsiveSpacing(context, 25)),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (isTablet)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _TextForm(
                                        controller: _emailController, t: t),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: _TextForm2(
                                        controller: _passwordController, t: t),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  _TextForm(controller: _emailController, t: t),
                                  SizedBox(
                                      height: Responsive.responsiveSpacing(
                                          context, 15)),
                                  _TextForm2(
                                      controller: _passwordController, t: t),
                                ],
                              ),
                            SizedBox(
                                height:
                                    Responsive.responsiveSpacing(context, 10)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  t.forgotPassword,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    Responsive.responsiveSpacing(context, 25)),
                            Login(
                              t: t,
                              isLoading: state is AuthLoading && _isEmailLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _isEmailLoading = true);
                                  context.read<AuthCubit>().signIn(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      );
                                }
                              },
                            ),
                            SizedBox(
                                height:
                                    Responsive.responsiveSpacing(context, 25)),
                            Line(t: t),
                            SizedBox(
                                height:
                                    Responsive.responsiveSpacing(context, 15)),
                            Line2(t: t),
                            SizedBox(
                                height:
                                    Responsive.responsiveSpacing(context, 20)),
                            Final(
                              t: t,
                              isLoading:
                                  state is AuthLoading && _isGoogleLoading,
                              onPressed: () {
                                setState(() => _isGoogleLoading = true);
                                context.read<AuthCubit>().signInWithGoogle();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  final AppStrings t;
  const _LoginHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Column(
      children: [
        if (!isTablet) SizedBox(height: Responsive.responsiveSpacing(context, 20)),
        Text(
          t.welcomeBack,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 30 : 26,
            color: Colors.grey[900],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.loginSubtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: isTablet ? 17 : 15,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _TextForm extends StatelessWidget {
  final TextEditingController controller;
  final AppStrings t;
  const _TextForm({required this.controller, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, t.email), _input1(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 4),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kGrey900,
          ),
        ),
      );
  Widget _input1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffEEEEEE), width: 1.5),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 15),
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
            fontSize: 15,
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          errorStyle: const TextStyle(height: 0.8, fontSize: 12),
        ),
      ),
    );
  }
}

class _TextForm2 extends StatefulWidget {
  final TextEditingController controller;
  final AppStrings t;
  const _TextForm2({required this.controller, required this.t});

  @override
  State<_TextForm2> createState() => _TextForm2State();
}

class _TextForm2State extends State<_TextForm2> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_label(context, widget.t.password), _input(context)],
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 4),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kGrey900,
          ),
        ),
      );

  Widget _input(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffEEEEEE), width: 1.5),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscure,
        style: const TextStyle(color: Colors.black, fontSize: 15),
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
              size: 22,
            ),
          ),
          hintStyle: GoogleFonts.roboto(
            fontSize: 15,
            color: const Color(0xFFE0E0E0),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          errorStyle: const TextStyle(height: 0.8, fontSize: 12),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final AppStrings t;
  const Login(
      {super.key,
      required this.onPressed,
      required this.t,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: isLoading ? t.loading : t.loginButton,
      button: true,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff54408C),
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child:
                    CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : Text(
                t.login,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  final AppStrings t;
  const Line({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.dontHaveAccount,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 15,
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
            context.push('/signup');
          },
          child: Text(
            " ${t.signUp}",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class Line2 extends StatelessWidget {
  final AppStrings t;
  const Line2({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            t.orWith,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class Final extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final AppStrings t;
  const Final(
      {super.key,
      required this.onPressed,
      required this.t,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                    color: Colors.black, strokeWidth: 2.5),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetData.google, width: 18),
                  const SizedBox(width: 12),
                  Text(
                    t.googleSignIn,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

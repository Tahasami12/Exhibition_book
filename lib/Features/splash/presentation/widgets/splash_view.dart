import 'package:exhibition_book/Features/splash/presentation/widgets/splash_view_body.dart';
import 'package:exhibition_book/costants.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body:SplasViewBody(),
    );
  }
}
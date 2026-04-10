import 'package:exhibition_book/features/splash/presentation/widgets/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';
import 'features/home/presentation/views/home_view.dart';

void main() {
  //runApp(Category());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(

          scaffoldBackgroundColor: AppColors.background,


          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,),)

    );

  }
}


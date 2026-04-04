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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: " Bookly App",
      home: SplashView(),
    );
  

    // return  return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       home: const HomeView(),
    //     );MaterialApp.router(
    //     routerConfig: AppRouter.router,
    //     title: 'Flutter Demo',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData.light().copyWith(
    //
    //       scaffoldBackgroundColor: AppColors.background,
    //
    //
    //       appBarTheme: const AppBarTheme(
    //         backgroundColor: AppColors.background,
    //         elevation: 0,),)
    //    //home: Category(),
    // );

  }
}


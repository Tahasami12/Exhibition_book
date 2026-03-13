import 'package:exhibition_book/Features/profile/screens/profile.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';

void main() {
  //runApp(Profile());
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
      // home: Category(),
    );

  }
}


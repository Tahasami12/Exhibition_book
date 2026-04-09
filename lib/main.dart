import 'package:exhibition_book/features/profile/screens/favorites.dart';
import 'package:exhibition_book/features/profile/screens/help_center.dart';
import 'package:exhibition_book/features/profile/screens/my_account.dart';
import 'package:exhibition_book/features/profile/screens/offers.dart';
import 'package:exhibition_book/features/profile/screens/order_history.dart';
import 'package:exhibition_book/features/profile/screens/profile.dart';
import 'package:exhibition_book/features/splash/presentation/widgets/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';
import 'features/home/presentation/views/home_view.dart';

void main() {
  //runApp(Category());
  // runApp(const MyApp());
  // runApp(MyAccount());
  // runApp(Offers());
  // runApp(HelpCenter());
  // runApp(OrderHistory());
  // runApp(Favorites());
  runApp(Profile());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
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

import 'package:exhibition_book/features/category/view/category_screen.dart';
import 'package:exhibition_book/features/search/ view/search_home.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/main_shell.dart';
import '../../features/splash/presentation/widgets/login_screen.dart';
import '../../features/splash/presentation/widgets/on_boarding.dart';
import '../../features/splash/presentation/widgets/on_boarding_2.dart';
import '../../features/splash/presentation/widgets/on_boarding_3.dart';
import '../../features/splash/presentation/widgets/signUp.dart';
import '../../features/splash/presentation/widgets/splash_view.dart';

abstract class AppRouter {

  static const kHome = '/home';
  static const kSearchHome = '/searchHome';
  static const kCategory= '/category';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const  SplashView(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnBoarding(),
      ),
      GoRoute(
        path: kSearchHome,
        builder: (context, state) => const SearchHome(),
      ),
      GoRoute(
        path: kCategory,
        builder: (context, state) => const  CategoryScreen(),
      ),
      // /home now points to MainShell which manages all four tabs
      GoRoute(
        path: kHome,
        builder: (context, state) => const MainShell(),
      ),
      GoRoute(
        path: '/onboarding2',
        builder: (context, state) => const OnBoarding2(),
      ),

      GoRoute(
        path: '/signup',
        builder: (context, state) => const Signup(),

      ),
      GoRoute(
        path: '/onboarding3',
        builder: (context, state) => const OnBoarding3(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const Signup(),
      ),

    ],
  );
}
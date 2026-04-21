import 'package:exhibition_book/features/category/view/category_screen.dart';
import 'package:exhibition_book/features/search/ view/search_home.dart';
import 'package:exhibition_book/features/admin/presentation/views/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/main_shell.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/splash/presentation/widgets/on_boarding.dart';
import '../../features/splash/presentation/widgets/on_boarding_2.dart';
import '../../features/splash/presentation/widgets/on_boarding_3.dart';
import '../../features/auth/presentation/views/sign_up.dart';
import '../../features/splash/presentation/widgets/splash_view.dart';

/// انيميشن مخصص: slide من اليمين لليسار + fade
CustomTransitionPage<void> _buildPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: Curves.easeInOut),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

abstract class AppRouter {
  static const kHome = '/home';
  static const kSearchHome = '/searchHome';
  static const kCategory = '/category';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const SplashView(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const OnBoarding(),
        ),
      ),
      GoRoute(
        path: '/onboarding2',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const OnBoarding2(),
        ),
      ),
      GoRoute(
        path: '/onboarding3',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const OnBoarding3(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const Signup(),
        ),
      ),
      GoRoute(
        path: kHome,
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const MainShell(),
        ),
      ),
      GoRoute(
        path: kSearchHome,
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const SearchHome(),
        ),
      ),
      GoRoute(
        path: kCategory,
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const CategoryScreen(),
        ),
      ),
      GoRoute(
        path: '/admin',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const AdminView(),
        ),
      ),
    ],
  );
}
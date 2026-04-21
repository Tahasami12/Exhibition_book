import 'package:exhibition_book/features/category/view/category_screen.dart';
import 'package:exhibition_book/features/search/ view/search_home.dart';
import 'package:exhibition_book/features/admin/presentation/views/admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/books_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/add_edit_book_view.dart';
import 'package:exhibition_book/features/home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/main_shell.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/splash/presentation/widgets/on_boarding.dart';
import '../../features/splash/presentation/widgets/on_boarding_2.dart';
import '../../features/splash/presentation/widgets/on_boarding_3.dart';
import '../../features/auth/presentation/views/sign_up.dart';
import '../../features/splash/presentation/widgets/splash_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/authors_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/add_edit_author_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/vendors_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/add_edit_vendor_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/users_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/orders_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/promotions_admin_view.dart';
import 'package:exhibition_book/features/admin/presentation/views/add_edit_promotion_view.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'package:exhibition_book/features/home/data/models/vendor_model.dart';
import 'package:exhibition_book/features/home/data/models/promotion_model.dart';
import 'package:exhibition_book/features/chat/presentation/views/admin_chats_view.dart';

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
      GoRoute(
        path: '/admin_books',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: const BooksAdminView(),
        ),
      ),
      GoRoute(
        path: '/add_edit_book',
        pageBuilder: (context, state) => _buildPage(
          context: context,
          state: state,
          child: AddEditBookView(book: state.extra as BookModel?),
        ),
      ),
      GoRoute(
        path: '/admin_authors',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const AuthorsAdminView()),
      ),
      GoRoute(
        path: '/add_edit_author',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: AddEditAuthorView(author: state.extra as AuthorModel?)),
      ),
      GoRoute(
        path: '/admin_vendors',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const VendorsAdminView()),
      ),
      GoRoute(
        path: '/add_edit_vendor',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: AddEditVendorView(vendor: state.extra as VendorModel?)),
      ),
      GoRoute(
        path: '/admin_users',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const UsersAdminView()),
      ),
      GoRoute(
        path: '/admin_orders',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const OrdersAdminView()),
      ),
      GoRoute(
        path: '/admin_promotions',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const PromotionsAdminView()),
      ),
      GoRoute(
        path: '/add_edit_promotion',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: AddEditPromotionView(promotion: state.extra as PromotionModel?)),
      ),
      GoRoute(
        path: '/admin_chats',
        pageBuilder: (context, state) => _buildPage(context: context, state: state, child: const AdminChatsView()),
      ),
    ],
  );
}
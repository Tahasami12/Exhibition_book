


import 'package:go_router/go_router.dart';

import '../../Features/category/view/category_screen.dart';
import '../../Features/search/ view/search_home.dart';

abstract class AppRouter {
  static const kSearchHome = '/searchHome';
  static const kCategory= '/category';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const  CategoryScreen(),
      ),
      GoRoute(
        path: kSearchHome,
        builder: (context, state) => const SearchHome(),
      ),
      GoRoute(
        path: kCategory,
        builder: (context, state) => const  CategoryScreen(),
      ),
    ],
  );
}
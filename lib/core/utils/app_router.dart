import 'package:exhibition_book/features/category/view/category_screen.dart';
import 'package:exhibition_book/features/search/%20view/search_home.dart';
import 'package:go_router/go_router.dart';

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
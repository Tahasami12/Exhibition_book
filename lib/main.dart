import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:exhibition_book/core/api/book_repository.dart';
import 'package:exhibition_book/features/home/presentation/cubit/books_cubit.dart';
import 'package:exhibition_book/core/api/promotion_repository.dart';
import 'package:exhibition_book/features/home/presentation/cubit/promotions_cubit.dart';
import 'package:exhibition_book/core/api/vendor_repository.dart';
import 'package:exhibition_book/features/home/presentation/cubit/vendors_cubit.dart';
import 'package:exhibition_book/core/api/author_repository.dart';
import 'package:exhibition_book/features/home/presentation/cubit/authors_cubit.dart';
import 'package:exhibition_book/features/profile/cubit/favorites_cubit.dart';
import 'package:exhibition_book/features/profile/data/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/cart_feature/presentation/cubit/cart_cubit.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final bookRepository = BookRepository();
  final promotionRepository = PromotionRepository();
  final vendorRepository = VendorRepository();
  final authorRepository = AuthorRepository();
  final favoritesRepository = FavoritesRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: bookRepository),
        RepositoryProvider.value(value: promotionRepository),
        RepositoryProvider.value(value: vendorRepository),
        RepositoryProvider.value(value: authorRepository),
        RepositoryProvider.value(value: favoritesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => BooksCubit(bookRepository)..fetchBooks()),
          BlocProvider(
            create:
                (_) => PromotionsCubit(promotionRepository)..fetchPromotions(),
          ),
          BlocProvider(
            create: (_) => VendorsCubit(vendorRepository)..fetchVendors(),
          ),
          BlocProvider(
            create: (_) => AuthorsCubit(authorRepository)..fetchAuthors(),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(favoritesRepository)..loadFavorites(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
      ),
    );
  }
}

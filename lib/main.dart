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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:exhibition_book/features/cart_feature/presentation/cubit/cart_cubit.dart';
import 'package:exhibition_book/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exhibition_book/features/auth/data/auth_repository.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider(create: (_) => BooksCubit(BookRepository())..fetchBooks()),
        BlocProvider(
          create:
              (_) => PromotionsCubit(PromotionRepository())..fetchPromotions(),
        ),
        BlocProvider(
          create: (_) => VendorsCubit(VendorRepository())..fetchVendors(),
        ),
        BlocProvider(
          create: (_) => AuthorsCubit(AuthorRepository())..fetchAuthors(),
        ),
      ],
      child: const MyApp(),
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

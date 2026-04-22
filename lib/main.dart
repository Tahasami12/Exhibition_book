import 'package:exhibition_book/features/admin/presentation/cubit/admin_books_cubit.dart';
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
import 'package:exhibition_book/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exhibition_book/features/auth/data/auth_repository.dart';
import 'package:exhibition_book/core/utils/cache_helper.dart';
import 'package:exhibition_book/core/cubit/locale_cubit.dart';
import 'package:exhibition_book/core/theme/app_theme.dart';
import 'core/utils/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:exhibition_book/features/admin/data/repositories/admin_users_repository.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_users_cubit.dart';
import 'package:exhibition_book/features/admin/data/repositories/admin_orders_repository.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_orders_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_promotions_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_authors_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_vendors_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();

  final bookRepository = BookRepository();
  final promotionRepository = PromotionRepository();
  final vendorRepository = VendorRepository();
  final authorRepository = AuthorRepository();
  final favoritesRepository = FavoritesRepository();
  final adminUsersRepository = AdminUsersRepository();
  final adminOrdersRepository = AdminOrdersRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: bookRepository),
        RepositoryProvider.value(value: promotionRepository),
        RepositoryProvider.value(value: vendorRepository),
        RepositoryProvider.value(value: authorRepository),
        RepositoryProvider.value(value: favoritesRepository),
        RepositoryProvider.value(value: adminUsersRepository),
        RepositoryProvider.value(value: adminOrdersRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(AuthRepository())),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => BooksCubit(bookRepository)..fetchBooks()),
          BlocProvider(create: (_) => AdminBooksCubit(bookRepository)),
          BlocProvider(create: (_) => AdminAuthorsCubit(authorRepository)),
          BlocProvider(create: (_) => AdminVendorsCubit(vendorRepository)),
          BlocProvider(create: (_) => AdminUsersCubit(adminUsersRepository)),
          BlocProvider(create: (_) => AdminOrdersCubit(adminOrdersRepository)),
          BlocProvider(
            create: (_) => AdminPromotionsCubit(promotionRepository),
          ),
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
          BlocProvider(create: (_) => FavoritesCubit(favoritesRepository)..loadFavorites()),
          BlocProvider(create: (_) => LocaleCubit()),
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
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: localeState.isArabic ? const Locale('ar') : const Locale('en'),
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

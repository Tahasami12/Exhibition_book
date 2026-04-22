import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/profile_helpers.dart';
import '../../home/presentation/views/book_details_view.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../models/favorite_model.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: makeAppBar(
        title: "Your Favorites",
        titleColor: AppColors.textPrimary,
        enableLeading: true,
        barBackgroundColor: AppColors.background,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoritesError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.red,
                      size: 44,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FavoritesCubit>().loadFavorites();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const _EmptyFavoritesView();
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: state.favorites.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return _FavoriteBookTile(favorite: favorite);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FavoriteBookTile extends StatelessWidget {
  const _FavoriteBookTile({required this.favorite});

  final FavoriteModel favorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailsPage(book: favorite.toBook()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 56,
                height: 70,
                child: _FavoriteBookImage(imageUrl: favorite.imageUrl),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.grey900,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    favorite.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.grey500,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "EGP ${favorite.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<FavoritesCubit>().removeFavorite(favorite.id);
              },
              icon: const Icon(
                Icons.favorite,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteBookImage extends StatelessWidget {
  const _FavoriteBookImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() {
    return Container(
      color: AppColors.grey100,
      child: const Icon(
        Icons.book,
        color: AppColors.grey500,
      ),
    );
  }
}

class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.favorite_border,
              size: 60,
              color: AppColors.grey500,
            ),
            SizedBox(height: 16),
            Text(
              'No favorite books yet.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the heart icon on any book details page to add it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/core/utils/app_router.dart';
import 'package:exhibition_book/features/cart_feature/presentation/cubit/cart_cubit.dart';
import 'package:exhibition_book/features/cart_feature/data/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/home/data/models/book_model.dart';
import 'package:exhibition_book/features/profile/cubit/favorites_cubit.dart';
import 'package:exhibition_book/features/profile/cubit/favorites_state.dart';
import 'package:exhibition_book/features/home/presentation/views/main_shell.dart';

/// Product details screen for a single book.
/// Displays cover image, title, author, description, rating,
/// a quantity picker, and action buttons (Continue Shopping / Add to Cart).
class BookDetailsPage extends StatefulWidget {
  final BookModel book;
  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  int quantity = 1;

  // ── Design tokens (unified across this screen) ──
  static const _primaryColor = Color(0xFF54408C);
  static const _accentOrange = Color(0xFFFF9800);
  static const _starColor = Color(0xFFFFC107);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      // ── Back button ──
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          t.bookDetails,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context) ?? double.infinity,
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: Responsive.responsiveSpacing(context, 8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveSpacing(context, 24),
                vertical: Responsive.responsiveSpacing(context, 24),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Responsive.isMobile(context)
                  ? _buildMobileLayout(context, t, screenWidth, screenHeight)
                  : _buildTabletLayout(context, t, screenWidth, screenHeight),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, AppStrings t, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(context, width, height),
        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
        _buildTitleAndFavorite(context, t),
        SizedBox(height: Responsive.responsiveSpacing(context, 6)),
        _buildAuthor(context),
        SizedBox(height: Responsive.responsiveSpacing(context, 12)),
        _buildDescription(context),
        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
        _buildReviewSection(context, t),
        SizedBox(height: Responsive.responsiveSpacing(context, 20)),
        _buildPriceAndQuantity(context, t),
        SizedBox(height: Responsive.responsiveSpacing(context, 24)),
        _buildActionButtons(context, t),
        SizedBox(height: Responsive.responsiveSpacing(context, 16)),
      ],
    );
  }

  Widget _buildTabletLayout(
      BuildContext context, AppStrings t, double width, double height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side: Image
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildCoverImage(context, width, height, isTablet: true),
              SizedBox(height: Responsive.responsiveSpacing(context, 24)),
              _buildReviewSection(context, t),
            ],
          ),
        ),
        SizedBox(width: Responsive.responsiveSpacing(context, 32)),
        // Right Side: Details
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleAndFavorite(context, t),
              SizedBox(height: Responsive.responsiveSpacing(context, 12)),
              _buildAuthor(context),
              SizedBox(height: Responsive.responsiveSpacing(context, 24)),
              _buildDescription(context),
              SizedBox(height: Responsive.responsiveSpacing(context, 32)),
              _buildPriceAndQuantity(context, t),
              SizedBox(height: Responsive.responsiveSpacing(context, 32)),
              _buildActionButtons(context, t),
              SizedBox(height: Responsive.responsiveSpacing(context, 16)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoverImage(BuildContext context, double width, double height,
      {bool isTablet = false}) {
    return Container(
      height: isTablet ? height * 0.5 : height * 0.35,
      width: isTablet ? double.infinity : width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(widget.book.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleAndFavorite(BuildContext context, AppStrings t) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.book.title(AppStrings.isArabic(context)),
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFavorite =
                context.read<FavoritesCubit>().isFavorite(widget.book.id);
            return IconButton(
              onPressed: () {
                final favoritesCubit = context.read<FavoritesCubit>();
                final wasFavorite = favoritesCubit.isFavorite(widget.book.id);
                favoritesCubit.toggleFavorite(widget.book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wasFavorite
                          ? '"${widget.book.title(AppStrings.isArabic(context))}" ${t.removedFromFav}'
                          : '"${widget.book.title(AppStrings.isArabic(context))}" ${t.addedToFav}',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _primaryColor,
                size: 24,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAuthor(BuildContext context) {
    return Text(
      widget.book.author(AppStrings.isArabic(context)),
      style: TextStyle(
        color: _accentOrange,
        fontSize: Responsive.responsiveFontSize(context, 14),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      widget.book.description(AppStrings.isArabic(context)),
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: Responsive.responsiveFontSize(context, 14),
        height: 1.6,
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context, AppStrings t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.review,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 8)),
        Row(
          children: [
            ...List.generate(
                4, (_) => const Icon(Icons.star, color: _starColor, size: 20)),
            const Icon(Icons.star_half, color: _starColor, size: 20),
            SizedBox(width: Responsive.responsiveSpacing(context, 8)),
            Text(
              "(${widget.book.rating.toStringAsFixed(1)})",
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantity(BuildContext context, AppStrings t) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EGP ${widget.book.price.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 22),
            fontWeight: FontWeight.w700,
            color: _primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSpacing(context, 4),
            vertical: Responsive.responsiveSpacing(context, 4),
          ),
          child: Row(
            children: [
              _QuantityButton(
                icon: Icons.remove,
                backgroundColor: Colors.grey[200]!,
                iconColor: Colors.black54,
                onPressed: () {
                  if (quantity > 1) setState(() => quantity--);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.responsiveSpacing(context, 16),
                ),
                child: Text(
                  "$quantity",
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _QuantityButton(
                icon: Icons.add,
                backgroundColor: _primaryColor,
                iconColor: Colors.white,
                onPressed: () => setState(() => quantity++),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, AppStrings t) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Responsive.responsiveSpacing(context, 48),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                MainShellController.showHome();
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return;
                }
                context.go(AppRouter.kHome);
              },
              child: Text(
                t.continueShopping,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveFontSize(context, 14),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Responsive.responsiveSpacing(context, 12)),
        Expanded(
          child: SizedBox(
            height: Responsive.responsiveSpacing(context, 48),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: _primaryColor,
                side: const BorderSide(color: _primaryColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final cartItem = CartItem(
                  id: widget.book.id,
                  titleAr: widget.book.titleAr,
                  titleEn: widget.book.titleEn,
                  authorAr: widget.book.authorAr,
                  authorEn: widget.book.authorEn,
                  price: widget.book.price,
                  quantity: quantity,
                  imageUrl: widget.book.imageUrl,
                );
                context.read<CartCubit>().addItem(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                            '$quantity × "${widget.book.title(AppStrings.isArabic(context))}" ${t.addedToCartMsg}'),
                      ],
                    ),
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                t.addToCart,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveFontSize(context, 14),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Circular quantity adjustment button used in the picker.
class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: iconColor, size: 18),
        ),
      ),
    );
  }
}

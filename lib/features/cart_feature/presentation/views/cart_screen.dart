import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../../data/cart_item.dart';
import '../cubit/cart_cubit.dart';
import 'confirm_order_screen.dart';

/// Cart screen that displays all items added via CartCubit.
/// Uses `BlocBuilder<CartCubit, CartState>` to reactively rebuild when items change.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          // Debug: verify the BlocBuilder is receiving updates
          debugPrint('CartScreen rebuild: ${state.items.length} items');

          if (state.isEmpty) {
            return const _EmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: Responsive.responsivePadding(context),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return _CartItemCard(
                      item: item,
                      onIncrease: () => context.read<CartCubit>().increaseQuantity(item.id),
                      onDecrease: () => context.read<CartCubit>().decreaseQuantity(item.id),
                      onRemove: () => context.read<CartCubit>().removeItem(item.id),
                    );
                  },
                ),
              ),
              _CheckoutBar(
                total: state.total,
                onCheckout: () {
                  if (state.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cart is empty')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConfirmOrderScreen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Shown when the cart has no items.
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: Responsive.responsiveIconSize(context, 64),
            color: Colors.grey,
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 16)),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 18),
              color: Colors.grey,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          Text(
            'Add items from the Home tab',
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 14),
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual cart item card showing cover, details, and quantity controls.
class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: Responsive.responsiveSpacing(context, 16),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          Responsive.responsiveSpacing(context, 12),
        ),
        child: Row(
          children: [
            _buildCover(context),
            SizedBox(width: Responsive.responsiveSpacing(context, 16)),
            Expanded(child: _buildDetails(context)),
            _buildQuantityControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Responsive.responsiveBorderRadius(context, 8),
      ),
      child: Container(
        width: Responsive.responsiveImageSize(context, 80),
        height: Responsive.responsiveImageSize(context, 100),
        color: Colors.grey[200],
        child: item.imageUrl.isNotEmpty
            ? Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.book,
                  size: Responsive.responsiveIconSize(context, 40),
                  color: Colors.grey,
                ),
              )
            : Icon(
                Icons.book,
                size: Responsive.responsiveIconSize(context, 40),
                color: Colors.grey,
              ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.responsiveFontSize(context, 16),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 4)),
        Text(
          item.author,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: Responsive.responsiveFontSize(context, 14),
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 8)),
        Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF54408C),
            fontSize: Responsive.responsiveFontSize(context, 16),
          ),
        ),
        TextButton(
          onPressed: onRemove,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Remove',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: Responsive.responsiveIconSize(context, 20),
          ),
          onPressed: onIncrease,
        ),
        Text(
          '${item.quantity}',
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 16),
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            size: Responsive.responsiveIconSize(context, 20),
          ),
          onPressed: onDecrease,
        ),
      ],
    );
  }
}

/// Bottom bar showing the total price and checkout button.
class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({
    required this.total,
    required this.onCheckout,
  });

  final double total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.responsivePadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 20),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF54408C),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 16)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF54408C),
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.responsiveSpacing(context, 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Responsive.responsiveBorderRadius(context, 12),
                  ),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
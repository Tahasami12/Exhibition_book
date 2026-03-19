import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/responsive.dart';
import '../../data/cart_item.dart';
import '../view_model/cart_state.dart';
import '../view_model/cart_view_model.dart';
import 'confirm_order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CartView();
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  void _handleMessages(BuildContext context, CartState state) {
    if (state.message == 'removed') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item removed')),
      );
    } else if (state.message == 'empty') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartViewModel, CartState>(
      listener: (context, state) {
        _handleMessages(context, state);

        if (state.shouldNavigateToConfirm) {
          context.read<CartViewModel>().acknowledgeNavigation();
          Get.to(() => const ConfirmOrderScreen());
        }
      },
      builder: (context, state) {
        final viewModel = context.read<CartViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 20),
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = Responsive.maxContentWidth(context);

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? double.infinity,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: state.isEmpty
                            ? const _EmptyCart()
                            : ListView.builder(
                          padding: Responsive.responsivePadding(context),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];

                            return _CartItemCard(
                              item: item,
                              onIncrease: () =>
                                  viewModel.increaseQuantity(item.id),
                              onDecrease: () =>
                                  viewModel.decreaseQuantity(item.id),
                              onRemove: () =>
                                  viewModel.removeItem(item.id),
                            );
                          },
                        ),
                      ),
                      if (!state.isEmpty)
                        _CheckoutBar(
                          total: state.total,
                          onCheckout: viewModel.checkout,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

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
        ],
      ),
    );
  }
}

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
    return Container(
      width: Responsive.responsiveImageSize(context, 80),
      height: Responsive.responsiveImageSize(context, 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 8),
        ),
        color: Colors.grey[200],
      ),
      child: item.imageUrl.isNotEmpty
          ? Image.asset(
        item.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(
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
            color: const Color(0xFF6C47FF),
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
                  color: const Color(0xFF6C47FF),
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
                backgroundColor: const Color(0xFF6C47FF),
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
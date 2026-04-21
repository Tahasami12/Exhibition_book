import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:exhibition_book/features/cart_feature/data/order_repository.dart';
import 'package:exhibition_book/features/profile/cubit/user_order_history_cubit.dart';
import 'package:exhibition_book/features/profile/cubit/user_order_history_state.dart';
import 'package:exhibition_book/features/profile/screens/order_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocProvider(
      create: (context) => UserOrderHistoryCubit(OrderRepository())..fetchUserOrders(userId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: makeAppBar(
          title: "Order History",
          titleColor: AppColors.textPrimary,
          enableLeading: true,
          barBackgroundColor: Colors.white,
        ),
        body: BlocBuilder<UserOrderHistoryCubit, UserOrderHistoryState>(
          builder: (context, state) {
            if (state is UserOrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state is UserOrderHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(state.message, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserOrderHistoryCubit>().fetchUserOrders(userId);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              );
            }
            if (state is UserOrderHistoryLoaded) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text("You have no orders yet.",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsView(order: order),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order #${order.id.substring(0, 8).toUpperCase()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.textPrimary),
                              ),
                              _StatusBadge(status: order.status),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.date.isNotEmpty ? order.date.substring(0, 10) : 'Date not specified',
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.menu_book, size: 16, color: AppColors.grey500),
                                  const SizedBox(width: 6),
                                  Text(
                                    "${order.items.length} items",
                                    style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                "\$${order.totalAmount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String labelText;
    
    switch (status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        labelText = 'Pending';
        break;
      case 'confirmed':
        color = Colors.blue;
        labelText = 'Confirmed';
        break;
      case 'shipped':
        color = Colors.purple;
        labelText = 'Shipped';
        break;
      case 'delivered':
        color = Colors.green;
        labelText = 'Delivered';
        break;
      case 'cancelled':
        color = Colors.red;
        labelText = 'Cancelled';
        break;
      default:
        color = Colors.grey;
        labelText = status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        labelText,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
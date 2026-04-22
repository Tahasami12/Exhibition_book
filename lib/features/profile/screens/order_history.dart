import 'package:exhibition_book/core/utils/app_colors.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:exhibition_book/core/utils/profile_helpers.dart';
import 'package:exhibition_book/features/cart_feature/data/order_repository.dart';
import 'package:exhibition_book/features/profile/cubit/user_order_history_cubit.dart';
import 'package:exhibition_book/features/profile/cubit/user_order_history_state.dart';
import 'package:exhibition_book/features/profile/screens/order_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocProvider(
      create: (context) => UserOrderHistoryCubit(OrderRepository())..fetchUserOrders(userId),
      child: Scaffold(
        appBar: makeAppBar(
          title: t.orderHistory,
          titleColor: Theme.of(context).colorScheme.onSurface,
          enableLeading: true,
          barBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: BlocBuilder<UserOrderHistoryCubit, UserOrderHistoryState>(
          builder: (context, state) {
            if (state is UserOrderHistoryLoading) {
              return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
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
                      onPressed: () => context.read<UserOrderHistoryCubit>().fetchUserOrders(userId),
                      child: Text(t.retry),
                    ),
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
                      Text(
                        t.youHaveNoOrders,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                      ),
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
                          builder: (_) => OrderDetailsView(order: order),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        border: Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${t.orderNo}${order.id.substring(0, 8).toUpperCase()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              _StatusBadge(status: order.status, t: t),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order.date.isNotEmpty
                                ? order.date.substring(0, 10)
                                : t.notSpecified,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontSize: 13,
                            ),
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.menu_book, size: 16,
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)),
                                  const SizedBox(width: 6),
                                  Text(
                                    t.orderItems(order.items.length),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "EGP ${order.totalAmount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
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
  final AppStrings t;
  const _StatusBadge({required this.status, required this.t});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':   color = Colors.orange; break;
      case 'confirmed': color = Colors.blue;   break;
      case 'shipped':   color = Colors.purple; break;
      case 'delivered': color = Colors.green;  break;
      case 'cancelled': color = Colors.red;    break;
      default:          color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        t.statusLabel(status),
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';
import 'package:exhibition_book/features/admin/presentation/admin_theme.dart';
import 'package:exhibition_book/core/utils/responsive.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_orders_cubit.dart';
import 'package:exhibition_book/features/admin/presentation/cubit/admin_orders_state.dart';


class OrdersAdminView extends StatefulWidget {
  const OrdersAdminView({super.key});

  @override
  State<OrdersAdminView> createState() => _OrdersAdminViewState();
}

class _OrdersAdminViewState extends State<OrdersAdminView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminOrdersCubit>().fetchOrders();
  }



  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    return Scaffold(
      backgroundColor: AdminTheme.bg,
      appBar: AdminTheme.adminAppBar(
        title: t.manageOrders,
        context: context,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AdminOrdersCubit>().fetchOrders(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context) ?? double.infinity,
          ),
          child: BlocConsumer<AdminOrdersCubit, AdminOrdersState>(
            listener: (context, state) {
              if (state is AdminOrdersActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is AdminOrdersActionError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            buildWhen: (_, current) =>
                current is AdminOrdersLoading ||
                current is AdminOrdersLoaded ||
                current is AdminOrdersError,
            builder: (context, state) {
              if (state is AdminOrdersLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AdminOrdersError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 48),
                      const SizedBox(height: 12),
                      Text('Error: ${state.message}',
                          textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<AdminOrdersCubit>().fetchOrders(),
                        child: Text(t.retry),
                      ),
                    ],
                  ),
                );
              }
              if (state is AdminOrdersLoaded) {
                if (state.orders.isEmpty) {
                  return AdminTheme.emptyState(t.noOrders,
                      icon: Icons.shopping_bag_outlined);
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) =>
                      _OrderCard(order: state.orders[index]),
                );
              }
              return Center(child: Text(t.navHome)); // fallback
            },
          ),
        ),
      ),
    );
  }
}

// ─── Order Card ───────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final AdminOrderModel order;

  static const _statusColors = {
    'pending': Colors.orange,
    'confirmed': Colors.blue,
    'shipped': Colors.purple,
    'delivered': Colors.green,
    'cancelled': Colors.red,
  };

  static const _allStatuses = [
    'pending',
    'confirmed',
    'shipped',
    'delivered',
    'cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final statusColor =
        _statusColors[order.status] ?? Colors.grey;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showOrderDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.receipt_long,
                        color: statusColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${t.orderNoHash}${order.id.substring(0, 8).toUpperCase()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          order.date.isNotEmpty
                              ? order.date.substring(0, 10)
                              : t.notSpecified,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Status dropdown
                  PopupMenuButton<String>(
                    initialValue: order.status,
                    onSelected: (newStatus) {
                      if (newStatus != order.status) {
                        context
                            .read<AdminOrdersCubit>()
                            .updateOrderStatus(order.id, newStatus);
                      }
                    },
                    itemBuilder: (_) => _allStatuses
                        .map((s) => PopupMenuItem(
                            value: s,
                            child: Text(t.statusLabel(s))))
                        .toList(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        t.statusLabel(order.status),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              // Customer info
              _infoRow(t, Icons.person, t.customer, order.userName),
              if (order.phone.isNotEmpty)
                _infoRow(t, Icons.phone, t.phoneLabel, order.phone),
              if (order.address.isNotEmpty)
                _infoRow(t, Icons.location_on, t.addressLabel, order.address),
              const SizedBox(height: 8),
              // Items summary
              if (order.items.isNotEmpty) ...[
                Text(
                  t.booksLabelWithCount(order.items.length),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(height: 6),
                ...order.items.take(2).map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.book_outlined,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${item.title} × ${item.quantity}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text('EGP ${item.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                        ],
                      ),
                    )),
                if (order.items.length > 2)
                  Text(
                    '+ ${order.items.length - 2} ${t.moreItems}',
                    style:
                        const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
              ],
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.total,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    'EGP ${order.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF6C47FF)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(AppStrings t, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: Colors.grey),
          const SizedBox(width: 6),
          Text('$label: ',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 13),
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminOrdersCubit>(),
        child: _OrderDetailSheet(order: order),
      ),
    );
  }
}

// ─── Full Order Detail Sheet ──────────────────────────────────────────────────

class _OrderDetailSheet extends StatelessWidget {
  const _OrderDetailSheet({required this.order});
  final AdminOrderModel order;

  static const _statusColors = {
    'pending': Colors.orange,
    'confirmed': Colors.blue,
    'shipped': Colors.purple,
    'delivered': Colors.green,
    'cancelled': Colors.red,
  };

  static const _allStatuses = [
    'pending',
    'confirmed',
    'shipped',
    'delivered',
    'cancelled',
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final statusColor = _statusColors[order.status] ?? Colors.grey;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, controller) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ListView(
              controller: controller,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                // Title
                Text(
                  '${t.orderNoHash}${order.id.substring(0, 8).toUpperCase()}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(order.date.isNotEmpty ? order.date.substring(0, 10) : t.notSpecified,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 16),
    
                // Status change
                Row(
                  children: [
                    Text('${t.orderStatus}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    PopupMenuButton<String>(
                      initialValue: order.status,
                      onSelected: (newStatus) {
                        if (newStatus != order.status) {
                          context
                              .read<AdminOrdersCubit>()
                              .updateOrderStatus(order.id, newStatus);
                          Navigator.pop(context);
                        }
                      },
                      itemBuilder: (_) => _allStatuses
                          .map((s) => PopupMenuItem(
                              value: s,
                              child: Text(t.statusLabel(s))))
                          .toList(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          '${t.statusLabel(order.status)}  ▼',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
    
                // Customer section
                _sheetSection(t.customerInfo, [
                  _detailRow(t.nameLabel, order.userName),
                  _detailRow(t.phoneLabel,
                      order.phone.isNotEmpty ? order.phone : t.notSpecified),
                  _detailRow(t.email,
                      order.email.isNotEmpty ? order.email : t.notSpecified),
                  _detailRow(t.addressLabel,
                      order.address.isNotEmpty ? order.address : t.notSpecified),
                ]),
                const SizedBox(height: 16),
    
                // Items section
                _sheetSection(t.orderItemsLabel, [
                  ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: item.imageUrl.startsWith('http')
                                  ? Image.network(item.imageUrl,
                                      width: 44,
                                      height: 56,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.book, size: 44))
                                  : const Icon(Icons.book, size: 44),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(item.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  Text('${t.qtyLabel} ${item.quantity}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Text(
                                'EGP ${item.subtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                ]),
                const SizedBox(height: 16),
    
                // Payment section
                _sheetSection(t.paymentSummary, [
                  _detailRow(t.subtotal,
                      'EGP ${order.subtotal.toStringAsFixed(2)}'),
                  _detailRow(t.shipping,
                      'EGP ${order.shipping.toStringAsFixed(2)}'),
                  _detailRow(
                      t.tax, 'EGP ${order.tax.toStringAsFixed(2)}'),
                  _detailRow(t.discount,
                      '-EGP ${order.discount.toStringAsFixed(2)}'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.total,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text('EGP ${order.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF6C47FF))),
                    ],
                  ),
                ]),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sheetSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF6C47FF))),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text('$label:',
                style: const TextStyle(
                    color: Colors.grey, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

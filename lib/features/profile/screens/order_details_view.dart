import 'package:flutter/material.dart';
import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';
import 'package:exhibition_book/core/utils/app_strings.dart';

class OrderDetailsView extends StatelessWidget {
  final AdminOrderModel order;
  const OrderDetailsView({super.key, required this.order});

  static const _statusColors = {
    'pending':   Colors.orange,
    'confirmed': Colors.blue,
    'shipped':   Colors.purple,
    'delivered': Colors.green,
    'cancelled': Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final statusColor = _statusColors[order.status] ?? Colors.grey;
    final statusText  = t.statusLabel(order.status);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.orderDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: Order ID & Status ──────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? cs.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${t.orderNo}${order.id.substring(0, 8).toUpperCase()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(t.dateLabel, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.6))),
                      Text(
                        order.date.isNotEmpty ? order.date.substring(0, 10) : t.notSpecified,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Shipping Details ───────────────────────────────────────────
            Text(
              t.shippingDetails,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface),
            ),
            const SizedBox(height: 12),
            _infoRow(context, Icons.person_outline, t.nameLabel, order.userName),
            _infoRow(context, Icons.phone_outlined, t.phoneLabel,
                order.phone.isEmpty ? t.notProvided : order.phone),
            _infoRow(context, Icons.location_on_outlined, t.addressLabel,
                order.address.isEmpty ? t.notProvided : order.address),
            const SizedBox(height: 24),

            // ── Order Items ────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.orderItemsLabel,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface),
                ),
                Text(
                  t.orderItems(order.items.length),
                  style: TextStyle(color: cs.onSurface.withValues(alpha: 0.6)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color ?? cs.surface,
                    border: Border.all(color: theme.dividerColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: item.imageUrl.isNotEmpty
                            ? Image.network(
                                item.imageUrl,
                                width: 60,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _fallbackCover(context),
                              )
                            : _fallbackCover(context),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: cs.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${t.qtyLabel} ${item.quantity}',
                              style: TextStyle(color: cs.onSurface.withValues(alpha: 0.6)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'EGP ${item.price.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.w600, color: cs.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // ── Payment Summary ────────────────────────────────────────────
            Text(
              t.paymentSummary,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? cs.surface,
                border: Border.all(color: theme.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _summaryRow(context, t.subtotal, order.subtotal),
                  const SizedBox(height: 8),
                  _summaryRow(context, t.shipping, order.shipping),
                  const SizedBox(height: 8),
                  _summaryRow(context, t.tax, order.tax),
                  const SizedBox(height: 8),
                  _summaryRow(context, t.discount, -order.discount, isDiscount: true),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.totalPayment,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        'EGP ${order.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, IconData icon, String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: cs.onSurface.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(color: cs.onSurface.withValues(alpha: 0.6), fontSize: 12)),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: cs.onSurface)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, double amount,
      {bool isDiscount = false}) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.6))),
        Text(
          '${isDiscount ? '' : 'EGP '}${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDiscount ? Colors.green : cs.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _fallbackCover(BuildContext context) {
    return Container(
      width: 60,
      height: 80,
      color: Theme.of(context).dividerColor,
      child: const Icon(Icons.book, color: Colors.grey),
    );
  }
}

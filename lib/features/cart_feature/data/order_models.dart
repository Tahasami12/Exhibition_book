
import 'cart_item.dart';

class Order {
  final String id;
  final String date;
  final String status;
  final double total;
  final List<CartItem> items;

  const Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
  });

  Order copyWith({
    String? id,
    String? date,
    String? status,
    double? total,
    List<CartItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      total: total ?? this.total,
      items: items ?? this.items,
    );
  }
}

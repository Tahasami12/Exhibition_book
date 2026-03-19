
import '../../../../core/base/view_state.dart';
import '../../data/order_models.dart';

class OrdersState {
  final ViewStatus status;
  final List<Order> orders;
  final String? message;

  const OrdersState({
    this.status = ViewStatus.idle,
    this.orders = const [],
    this.message,
  });

  OrdersState copyWith({
    ViewStatus? status,
    List<Order>? orders,
    String? message,
    bool resetMessage = false,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      message: resetMessage ? null : message ?? this.message,
    );
  }
}

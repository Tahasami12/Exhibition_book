
import '../../../../core/base/view_state.dart';
import '../../data/cart_item.dart';

class CartState {
  final ViewStatus status;
  final List<CartItem> items;
  final String? message;
  final bool shouldNavigateToConfirm;

  const CartState({
    this.status = ViewStatus.idle,
    this.items = const [],
    this.message,
    this.shouldNavigateToConfirm = false,
  });

  double get total =>
      items.fold<double>(0, (sum, item) => sum + item.total);

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    ViewStatus? status,
    List<CartItem>? items,
    String? message,
    bool? shouldNavigateToConfirm,
    bool resetMessage = false,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      message: resetMessage ? null : message ?? this.message,
      shouldNavigateToConfirm:
          shouldNavigateToConfirm ?? this.shouldNavigateToConfirm,
    );
  }
}

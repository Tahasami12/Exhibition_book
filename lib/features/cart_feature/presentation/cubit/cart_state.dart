part of 'cart_cubit.dart';

class CartState {
  final List<CartItem> items;
  final ViewStatus status;
  final String? message;
  final bool shouldNavigateToConfirm;

  const CartState({
    this.items = const [],
    this.status = ViewStatus.idle,
    this.message,
    this.shouldNavigateToConfirm = false,
  });

  double get total => items.fold<double>(0, (sum, item) => sum + item.total);
  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItem>? items,
    ViewStatus? status,
    String? message,
    bool? shouldNavigateToConfirm,
    bool overrideMessage = false,
  }) {
    return CartState(
      items: items ?? this.items,
      status: status ?? this.status,
      message: overrideMessage ? message : (message ?? this.message),
      shouldNavigateToConfirm: shouldNavigateToConfirm ?? this.shouldNavigateToConfirm,
    );
  }
}

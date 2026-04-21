import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';

abstract class UserOrderHistoryState {}

class UserOrderHistoryInitial extends UserOrderHistoryState {}

class UserOrderHistoryLoading extends UserOrderHistoryState {}

class UserOrderHistoryLoaded extends UserOrderHistoryState {
  final List<AdminOrderModel> orders;
  UserOrderHistoryLoaded(this.orders);
}

class UserOrderHistoryError extends UserOrderHistoryState {
  final String message;
  UserOrderHistoryError(this.message);
}

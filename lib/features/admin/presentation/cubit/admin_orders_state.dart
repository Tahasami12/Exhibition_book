import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';

abstract class AdminOrdersState {}

class AdminOrdersInitial extends AdminOrdersState {}

class AdminOrdersLoading extends AdminOrdersState {}

class AdminOrdersLoaded extends AdminOrdersState {
  final List<AdminOrderModel> orders;
  AdminOrdersLoaded(this.orders);
}

class AdminOrdersError extends AdminOrdersState {
  final String message;
  AdminOrdersError(this.message);
}

class AdminOrdersActionLoading extends AdminOrdersState {}

class AdminOrdersActionSuccess extends AdminOrdersState {
  final String message;
  AdminOrdersActionSuccess(this.message);
}

class AdminOrdersActionError extends AdminOrdersState {
  final String message;
  AdminOrdersActionError(this.message);
}

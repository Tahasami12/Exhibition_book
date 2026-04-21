import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/admin/data/repositories/admin_orders_repository.dart';
import 'admin_orders_state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  final AdminOrdersRepository _repository;

  AdminOrdersCubit(this._repository) : super(AdminOrdersInitial());

  Future<void> fetchOrders() async {
    emit(AdminOrdersLoading());
    try {
      final orders = await _repository.getAllOrders();
      emit(AdminOrdersLoaded(orders));
    } catch (e) {
      emit(AdminOrdersError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    emit(AdminOrdersActionLoading());
    try {
      await _repository.updateOrderStatus(orderId, newStatus);
      emit(AdminOrdersActionSuccess('Order status updated to $newStatus'));
      await fetchOrders();
    } catch (e) {
      emit(AdminOrdersActionError(e.toString()));
      await fetchOrders();
    }
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/admin/data/repositories/admin_orders_repository.dart';
import 'admin_orders_state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  final AdminOrdersRepository _repository;

  AdminOrdersCubit(this._repository) : super(AdminOrdersInitial());
  StreamSubscription? _subscription;

  Future<void> fetchOrders() async {
    emit(AdminOrdersLoading());
    _subscription?.cancel();
    _subscription = _repository.streamOrders().listen(
      (orders) => emit(AdminOrdersLoaded(orders)),
      onError: (e) => emit(AdminOrdersError(e.toString())),
    );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    emit(AdminOrdersActionLoading());
    try {
      await _repository.updateOrderStatus(orderId, newStatus);
      emit(AdminOrdersActionSuccess('Order status updated to $newStatus'));
    } catch (e) {
      emit(AdminOrdersActionError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

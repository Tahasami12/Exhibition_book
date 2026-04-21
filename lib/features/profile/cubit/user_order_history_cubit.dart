import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/cart_feature/data/order_repository.dart';
import 'package:exhibition_book/features/profile/cubit/user_order_history_state.dart';

class UserOrderHistoryCubit extends Cubit<UserOrderHistoryState> {
  final OrderRepository _orderRepository;

  UserOrderHistoryCubit(this._orderRepository) : super(UserOrderHistoryInitial());

  Future<void> fetchUserOrders(String userId) async {
    if (userId.isEmpty) {
      emit(UserOrderHistoryError('User ID is missing.'));
      return;
    }
    emit(UserOrderHistoryLoading());
    try {
      final orders = await _orderRepository.fetchUserOrders(userId);
      emit(UserOrderHistoryLoaded(orders));
    } catch (e) {
      emit(UserOrderHistoryError(e.toString()));
    }
  }
}

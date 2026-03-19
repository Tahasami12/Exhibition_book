
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/view_state.dart';
import '../../data/order_models.dart';
import 'orders_state.dart';

class OrdersViewModel extends Cubit<OrdersState> {
  OrdersViewModel()
      : super(
          OrdersState(
            status: ViewStatus.success,
            orders: const [],
          ),
        );

  List<Order> filterByStatus(String status) {
    if (status == 'All') return state.orders;
    return state.orders.where((order) => order.status == status).toList();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'confirm_order_state.dart';

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit({double cartSubtotal = 0.0})
      : super(
          ConfirmOrderState(
            productSubtotal: cartSubtotal,
            shipping: 2.0,
            tax: cartSubtotal * 0.05,
            discount: 0.0,
          ),
        );
}

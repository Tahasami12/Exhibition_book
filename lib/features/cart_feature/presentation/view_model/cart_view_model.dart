
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/view_state.dart';
import '../../data/cart_item.dart';
import 'cart_state.dart';

class CartViewModel extends Cubit<CartState> {
  CartViewModel()
      : super(
          CartState(
            status: ViewStatus.success,
            items: const [],
          ),
        );

  void addItem(CartItem item) {
    final items = [...state.items];
    final existingIndex = items.indexWhere((value) => value.id == item.id);
    if (existingIndex != -1) {
      final existing = items[existingIndex];
      items[existingIndex] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
    } else {
      items.add(item);
    }

    emit(
      state.copyWith(
        items: items,
        status: ViewStatus.success,
        shouldNavigateToConfirm: false,
      ),
    );
  }

  void increaseQuantity(String id) {
    final updated = state.items.map((item) {
      if (item.id == id) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    emit(
      state.copyWith(
        items: updated,
        status: ViewStatus.success,
        resetMessage: true,
        shouldNavigateToConfirm: false,
      ),
    );
  }

  void decreaseQuantity(String id) {
    final List<CartItem> updated = [];
    for (final item in state.items) {
      if (item.id == id) {
        final newQty = item.quantity - 1;
        if (newQty > 0) {
          updated.add(item.copyWith(quantity: newQty));
        }
      } else {
        updated.add(item);
      }
    }
    emit(
      state.copyWith(
        items: updated,
        status: ViewStatus.success,
        message: updated.length < state.items.length
            ? 'removed'
            : null,
        shouldNavigateToConfirm: false,
      ),
    );
  }

  void removeItem(String id) {
    final updated = state.items.where((item) => item.id != id).toList();
    emit(
      state.copyWith(
        items: updated,
        status: ViewStatus.success,
        message: 'removed',
        shouldNavigateToConfirm: false,
      ),
    );
  }

  void checkout() {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          message: 'empty',
          shouldNavigateToConfirm: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: ViewStatus.success,
        shouldNavigateToConfirm: true,
        resetMessage: true,
      ),
    );
  }

  void acknowledgeNavigation() {
    emit(
      state.copyWith(
        shouldNavigateToConfirm: false,
      ),
    );
  }
}

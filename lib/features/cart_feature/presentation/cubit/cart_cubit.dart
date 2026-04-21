import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/base/view_state.dart';
import '../../data/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(CartItem item) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex = currentItems.indexWhere((value) => value.id == item.id);
    
    if (existingIndex != -1) {
      final existing = currentItems[existingIndex];
      currentItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
    } else {
      currentItems.add(item);
    }

    emit(state.copyWith(
      items: currentItems,
      status: ViewStatus.success,
      shouldNavigateToConfirm: false,
      message: null,
    ));
  }

  void increaseQuantity(String id) {
    final currentItems = List<CartItem>.from(state.items);
    for (int i = 0; i < currentItems.length; i++) {
      if (currentItems[i].id == id) {
        currentItems[i] = currentItems[i].copyWith(quantity: currentItems[i].quantity + 1);
        break;
      }
    }
    
    emit(state.copyWith(
      items: currentItems,
      status: ViewStatus.success,
      shouldNavigateToConfirm: false,
      message: null,
    ));
  }

  void decreaseQuantity(String id) {
    final currentItems = List<CartItem>.from(state.items);
    String? msg;
    
    for (int i = 0; i < currentItems.length; i++) {
      if (currentItems[i].id == id) {
        final newQty = currentItems[i].quantity - 1;
        if (newQty > 0) {
          currentItems[i] = currentItems[i].copyWith(quantity: newQty);
        } else {
          currentItems.removeAt(i);
          msg = 'removed';
        }
        break;
      }
    }
    
    emit(state.copyWith(
      items: currentItems,
      status: ViewStatus.success,
      shouldNavigateToConfirm: false,
      message: msg,
    ));
  }

  void removeItem(String id) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.id == id);
    
    emit(state.copyWith(
      items: currentItems,
      status: ViewStatus.success,
      message: 'removed',
      shouldNavigateToConfirm: false,
    ));
  }

  void checkout() {
    if (state.items.isEmpty) {
      emit(state.copyWith(
        status: ViewStatus.failure,
        message: 'empty',
        shouldNavigateToConfirm: false,
      ));
      return;
    }
    emit(state.copyWith(
      status: ViewStatus.success,
      shouldNavigateToConfirm: true,
      message: null,
    ));
  }

  void acknowledgeNavigation() {
    emit(state.copyWith(shouldNavigateToConfirm: false));
  }

  void clearCart() {
    emit(state.copyWith(
      items: [],
      status: ViewStatus.success,
      message: 'cleared',
    ));
  }

  void clearMessage() {
    emit(state.copyWith(message: null, overrideMessage: true));
  }
}

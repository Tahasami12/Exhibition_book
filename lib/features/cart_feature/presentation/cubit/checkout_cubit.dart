import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/features/cart_feature/data/cart_item.dart';
import 'package:exhibition_book/features/cart_feature/data/order_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final OrderRepository _orderRepository;

  CheckoutCubit(this._orderRepository) : super(CheckoutInitial());

  Future<void> placeOrder({
    required String customerName,
    required String phone,
    required String address,
    required List<CartItem> cartItems,
    required double subtotal,
    required double shipping,
    required double tax,
    required double discount,
    required double total,
    String? selectedDateTime,
  }) async {
    // ─── Validation ───────────────────────────────────
    if (cartItems.isEmpty) {
      emit(CheckoutValidationError('سلة التسوق فارغة'));
      return;
    }
    if (customerName.trim().isEmpty) {
      emit(CheckoutValidationError('من فضلك أدخل اسمك'));
      return;
    }
    if (phone.trim().isEmpty) {
      emit(CheckoutValidationError('من فضلك أدخل رقم هاتفك'));
      return;
    }
    if (phone.trim().length < 8) {
      emit(CheckoutValidationError('رقم الهاتف غير صحيح'));
      return;
    }
    if (address.trim().isEmpty) {
      emit(CheckoutValidationError('من فضلك أدخل عنوانك بالكامل'));
      return;
    }
    // ──────────────────────────────────────────────────

    emit(CheckoutLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> orderData = {
        'userId': user?.uid ?? '',
        'userName': customerName.trim(),
        'phone': phone.trim(),
        'email': user?.email ?? '',
        'address': address.trim(),
        'items': cartItems
            .map((item) => {
                  'bookId': item.id,
                  'title': item.title,
                  'imageUrl': item.imageUrl,
                  'price': item.price,
                  'quantity': item.quantity,
                })
            .toList(),
        'subtotal': subtotal,
        'shipping': shipping,
        'tax': tax,
        'discount': discount,
        'totalAmount': total,
        'date': DateTime.now().toIso8601String(),
        'selectedDateTime': selectedDateTime,
        'status': 'pending',
      };

      final orderId = await _orderRepository.placeOrder(orderData);
      emit(CheckoutSuccess(orderId));
    } catch (e) {
      emit(CheckoutError('فشل إرسال الطلب: $e'));
    }
  }

  void reset() => emit(CheckoutInitial());
}

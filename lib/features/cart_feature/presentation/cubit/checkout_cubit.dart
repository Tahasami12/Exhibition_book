import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> placeOrder({
    required String customerName,
    required String phone,
    required String address,
    required List<Map<String, dynamic>> cartItems,
    required double subtotal,
    required double shipping,
    required double tax,
    required double discount,
    required double total,
  }) async {
    emit(CheckoutLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;

      final Map<String, dynamic> orderData = {
        'userId': user?.uid ?? '',
        'userName': customerName.trim(),
        'phone': phone.trim(),
        'email': user?.email ?? '',
        'address': address.trim(),
        'items': cartItems,
        'subtotal': subtotal,
        'shipping': shipping,
        'tax': tax,
        'discount': discount,
        'totalAmount': total,
        'date': DateTime.now().toIso8601String(),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await FirebaseFirestore.instance
          .collection('orders')
          .add(orderData);

      emit(CheckoutSuccess(docRef.id));
    } catch (e) {
      emit(CheckoutError('Failed to place order: $e'));
    }
  }

  void reset() => emit(CheckoutInitial());
}

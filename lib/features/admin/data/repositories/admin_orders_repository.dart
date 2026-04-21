import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';

class AdminOrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AdminOrderModel>> getAllOrders() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => AdminOrderModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // fallback without ordering if index doesn't exist
      try {
        final snapshot = await _firestore.collection('orders').get();
        return snapshot.docs
            .map((doc) => AdminOrderModel.fromFirestore(doc.data(), doc.id))
            .toList();
      } catch (e2) {
        throw Exception('Failed to load orders: $e2');
      }
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': newStatus});
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Stream<List<AdminOrderModel>> streamOrders() {
    return _firestore
        .collection('orders')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => AdminOrderModel.fromFirestore(doc.data(), doc.id))
            .toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_book/features/admin/data/models/admin_order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Saves a fully-formed order document to Firestore and returns the new doc ID.
  Future<String> placeOrder(Map<String, dynamic> orderData) async {
    try {
      final docRef = await _firestore.collection('orders').add({
        ...orderData,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Has error $e');
    }
  }

  Future<List<AdminOrderModel>> fetchUserOrders(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          // Removed .orderBy('createdAt') to prevent composite index error
          .get();

      // Sort locally descending (newest first)
      final docs = snapshot.docs.toList();
      docs.sort((a, b) {
        final aData = a.data();
        final bData = b.data();
        final aTime = aData['createdAt'] as Timestamp?;
        final bTime = bData['createdAt'] as Timestamp?;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });

      return docs
          .map((doc) => AdminOrderModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Has error $e');
    }
  }
}

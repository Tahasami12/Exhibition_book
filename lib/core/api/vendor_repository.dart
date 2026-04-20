import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/vendor_model.dart';

class VendorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VendorModel>> getAllVendors() async {
    try {
      final snapshot = await _firestore.collection('vendors').get();
      return snapshot.docs.map((doc) {
        return VendorModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load vendors: $e');
    }
  }
}

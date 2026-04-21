import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/vendor_model.dart';

class VendorRepository {
  VendorRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

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

  Future<VendorModel> getVendorById(String vendorId) async {
    try {
      final snapshot = await _firestore.collection('vendors').doc(vendorId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('Vendor not found');
      }

      return VendorModel.fromFirestore(snapshot.data()!, snapshot.id);
    } catch (e) {
      throw Exception('Failed to load vendor details: $e');
    }
  }

  Future<void> addVendor(VendorModel vendor) async {
    try {
      await _firestore.collection('vendors').add(vendor.toJson());
    } catch (e) {
      throw Exception('Failed to add vendor: $e');
    }
  }

  Future<void> updateVendor(VendorModel vendor) async {
    try {
      await _firestore.collection('vendors').doc(vendor.id).update(vendor.toJson());
    } catch (e) {
      throw Exception('Failed to update vendor: $e');
    }
  }

  Future<void> deleteVendor(String id) async {
    try {
      await _firestore.collection('vendors').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete vendor: $e');
    }
  }
}

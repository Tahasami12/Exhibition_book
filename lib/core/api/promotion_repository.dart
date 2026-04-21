import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/promotion_model.dart';

class PromotionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<PromotionModel>> getPromotions() async {
    try {
      final snapshot = await _db.collection('promotions').get();
      return snapshot.docs.map((doc) => PromotionModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to load promotions: $e');
    }
  }

  Future<void> addPromotion(PromotionModel promotion) async {
    try {
      await _db.collection('promotions').add(promotion.toJson());
    } catch (e) {
      throw Exception('Failed to add promotion: $e');
    }
  }

  Future<void> updatePromotion(PromotionModel promotion) async {
    try {
      await _db.collection('promotions').doc(promotion.id).update(promotion.toJson());
    } catch (e) {
      throw Exception('Failed to update promotion: $e');
    }
  }

  Future<void> deletePromotion(String id) async {
    try {
      await _db.collection('promotions').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete promotion: $e');
    }
  }
}

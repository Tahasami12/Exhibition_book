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
}

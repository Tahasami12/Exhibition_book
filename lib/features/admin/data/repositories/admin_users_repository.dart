import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exhibition_book/features/admin/data/models/user_model.dart';

class AdminUsersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> changeUserRole(String uid, String newRole) async {
    try {
      await _firestore.collection('users').doc(uid).update({'role': newRole});
    } catch (e) {
      throw Exception('Failed to update role: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      // NOTE: This merely deletes the Firestore record (restricting their platform access).
      // True authentication deletion requires a Cloud Function or Admin SDK.
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}

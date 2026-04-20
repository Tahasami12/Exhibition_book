import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/author_model.dart';

class AuthorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AuthorModel>> getAllAuthors() async {
    try {
      final snapshot = await _firestore.collection('authors').get();
      return snapshot.docs.map((doc) {
        return AuthorModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load authors: $e');
    }
  }
}

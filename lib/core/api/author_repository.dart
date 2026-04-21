import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/author_model.dart';

class AuthorRepository {
  AuthorRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

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

  Future<AuthorModel> getAuthorById(String authorId) async {
    try {
      final snapshot = await _firestore.collection('authors').doc(authorId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('Author not found');
      }

      return AuthorModel.fromFirestore(snapshot.data()!, snapshot.id);
    } catch (e) {
      throw Exception('Failed to load author details: $e');
    }
  }
}

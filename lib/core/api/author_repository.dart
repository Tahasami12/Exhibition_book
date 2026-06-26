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

  Stream<List<AuthorModel>> getAuthorsStream() {
    return _firestore.collection('authors').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AuthorModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
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

  Future<void> addAuthor(AuthorModel author) async {
    try {
      await _firestore.collection('authors').add(author.toJson());
    } catch (e) {
      throw Exception('Failed to add author: $e');
    }
  }

  Future<void> updateAuthor(AuthorModel author) async {
    try {
      final batch = _firestore.batch();
      
      // 1. Update the author document
      final authorRef = _firestore.collection('authors').doc(author.id);
      batch.update(authorRef, author.toJson());

      // 2. Find all books by this author
      final booksSnapshot = await _firestore
          .collection('books')
          .where('authorId', isEqualTo: author.id)
          .get();

      // 3. Update the author name in each book
      for (var doc in booksSnapshot.docs) {
        batch.update(doc.reference, {
          'authorAr': author.nameAr,
          'authorEn': author.nameEn,
        });
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to update author and their books: $e');
    }
  }

  Future<void> deleteAuthor(String id) async {
    try {
      await _firestore.collection('authors').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete author: $e');
    }
  }
}

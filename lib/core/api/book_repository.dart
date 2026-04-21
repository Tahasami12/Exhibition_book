import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/home/data/models/book_model.dart';

class BookRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BookModel>> getAllBooks() async {
    try {
      final snapshot = await _db.collection('books').get();
      return snapshot.docs.map((doc) => BookModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }

  Future<void> addBook(BookModel book) async {
    try {
      final docRef = _db.collection('books').doc();
      final bookMap = book.toJson();
      if (bookMap['createdAt'] == null) {
        bookMap['createdAt'] = FieldValue.serverTimestamp();
      }
      await docRef.set(bookMap);
    } catch (e) {
      throw Exception('Failed to add book: $e');
    }
  }

  Future<void> updateBook(BookModel book) async {
    try {
      await _db.collection('books').doc(book.id).update(book.toJson());
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _db.collection('books').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }
}

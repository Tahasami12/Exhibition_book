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
}

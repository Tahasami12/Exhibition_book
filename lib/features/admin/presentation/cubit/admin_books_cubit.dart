import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/book_repository.dart';
import 'package:exhibition_book/features/home/data/models/book_model.dart';
import 'admin_books_state.dart';

class AdminBooksCubit extends Cubit<AdminBooksState> {
  final BookRepository _bookRepository;

  AdminBooksCubit(this._bookRepository) : super(AdminBooksInitial());

  Future<void> fetchBooks() async {
    emit(AdminBooksLoading());
    try {
      final books = await _bookRepository.getAllBooks();
      emit(AdminBooksLoaded(books));
    } catch (e) {
      emit(AdminBooksError(e.toString()));
    }
  }

  Future<void> addBook(BookModel book) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.addBook(book);
      emit(AdminBooksActionSuccess('Book added successfully'));
      await fetchBooks();
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
      await fetchBooks(); // restore loaded state
    }
  }

  Future<void> updateBook(BookModel book) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.updateBook(book);
      emit(AdminBooksActionSuccess('Book updated successfully'));
      await fetchBooks();
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
      await fetchBooks(); // restore loaded state
    }
  }

  Future<void> deleteBook(String id) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.deleteBook(id);
      emit(AdminBooksActionSuccess('Book deleted successfully'));
      await fetchBooks();
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
      await fetchBooks(); // restore loaded state
    }
  }
}

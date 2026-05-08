import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/book_repository.dart';
import 'package:exhibition_book/features/home/data/models/book_model.dart';
import 'admin_books_state.dart';

class AdminBooksCubit extends Cubit<AdminBooksState> {
  final BookRepository _bookRepository;

  AdminBooksCubit(this._bookRepository) : super(AdminBooksInitial());
  StreamSubscription? _subscription;

  Future<void> fetchBooks() async {
    emit(AdminBooksLoading());
    _subscription?.cancel();
    _subscription = _bookRepository.getBooksStream().listen(
      (books) => emit(AdminBooksLoaded(books)),
      onError: (e) => emit(AdminBooksError(e.toString())),
    );
  }

  Future<void> addBook(BookModel book) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.addBook(book);
      emit(AdminBooksActionSuccess('Book added successfully'));
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
    }
  }

  Future<void> updateBook(BookModel book) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.updateBook(book);
      emit(AdminBooksActionSuccess('Book updated successfully'));
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
    }
  }

  Future<void> deleteBook(String id) async {
    emit(AdminBooksActionLoading());
    try {
      await _bookRepository.deleteBook(id);
      emit(AdminBooksActionSuccess('Book deleted successfully'));
    } catch (e) {
      emit(AdminBooksActionError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

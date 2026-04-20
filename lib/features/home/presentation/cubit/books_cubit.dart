import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/book_repository.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final BookRepository _repository;

  BooksCubit(this._repository) : super(BooksInitial());

  Future<void> fetchBooks() async {
    emit(BooksLoading());
    try {
      final books = await _repository.getAllBooks();
      emit(BooksLoaded(books));
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }
}

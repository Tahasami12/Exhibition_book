import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/book_repository.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final BookRepository _repository;

  BooksCubit(this._repository) : super(BooksInitial());
  StreamSubscription? _subscription;

  Future<void> fetchBooks() async {
    emit(BooksLoading());
    _subscription?.cancel();
    _subscription = _repository.getBooksStream().listen(
      (books) => emit(BooksLoaded(books)),
      onError: (e) => emit(BooksError(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

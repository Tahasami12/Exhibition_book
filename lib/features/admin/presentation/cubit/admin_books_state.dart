import 'package:exhibition_book/features/home/data/models/book_model.dart';

abstract class AdminBooksState {}

class AdminBooksInitial extends AdminBooksState {}

class AdminBooksLoading extends AdminBooksState {}

class AdminBooksLoaded extends AdminBooksState {
  final List<BookModel> books;

  AdminBooksLoaded(this.books);
}

class AdminBooksError extends AdminBooksState {
  final String message;

  AdminBooksError(this.message);
}

class AdminBooksActionLoading extends AdminBooksState {}

class AdminBooksActionSuccess extends AdminBooksState {
  final String message;

  AdminBooksActionSuccess(this.message);
}

class AdminBooksActionError extends AdminBooksState {
  final String message;

  AdminBooksActionError(this.message);
}

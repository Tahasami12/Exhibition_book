import 'package:exhibition_book/features/home/data/models/author_model.dart';

abstract class AdminAuthorsState {}

class AdminAuthorsInitial extends AdminAuthorsState {}

class AdminAuthorsLoading extends AdminAuthorsState {}

class AdminAuthorsLoaded extends AdminAuthorsState {
  final List<AuthorModel> authors;

  AdminAuthorsLoaded(this.authors);
}

class AdminAuthorsError extends AdminAuthorsState {
  final String message;

  AdminAuthorsError(this.message);
}

class AdminAuthorsActionLoading extends AdminAuthorsState {}

class AdminAuthorsActionSuccess extends AdminAuthorsState {
  final String message;

  AdminAuthorsActionSuccess(this.message);
}

class AdminAuthorsActionError extends AdminAuthorsState {
  final String message;

  AdminAuthorsActionError(this.message);
}

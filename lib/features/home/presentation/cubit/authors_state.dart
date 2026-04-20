import '../../data/models/author_model.dart';

abstract class AuthorsState {}

class AuthorsInitial extends AuthorsState {}

class AuthorsLoading extends AuthorsState {}

class AuthorsLoaded extends AuthorsState {
  final List<AuthorModel> authors;
  AuthorsLoaded(this.authors);
}

class AuthorsError extends AuthorsState {
  final String message;
  AuthorsError(this.message);
}

import '../../data/models/author_model.dart';

abstract class AuthorDetailsState {}

class AuthorDetailsInitial extends AuthorDetailsState {}

class AuthorDetailsLoading extends AuthorDetailsState {}

class AuthorDetailsSuccess extends AuthorDetailsState {
  AuthorDetailsSuccess(this.author);

  final AuthorModel author;
}

class AuthorDetailsError extends AuthorDetailsState {
  AuthorDetailsError(this.message);

  final String message;
}

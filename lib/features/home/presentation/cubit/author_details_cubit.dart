import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/author_repository.dart';
import 'author_details_state.dart';

class AuthorDetailsCubit extends Cubit<AuthorDetailsState> {
  AuthorDetailsCubit(this._repository) : super(AuthorDetailsInitial());

  final AuthorRepository _repository;

  Future<void> fetchAuthorDetails(String authorId) async {
    emit(AuthorDetailsLoading());
    try {
      final author = await _repository.getAuthorById(authorId);
      emit(AuthorDetailsSuccess(author));
    } catch (e) {
      emit(AuthorDetailsError(e.toString()));
    }
  }
}

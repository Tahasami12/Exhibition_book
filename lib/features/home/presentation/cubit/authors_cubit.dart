import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/author_repository.dart';
import 'authors_state.dart';

class AuthorsCubit extends Cubit<AuthorsState> {
  final AuthorRepository _repository;

  AuthorsCubit(this._repository) : super(AuthorsInitial());

  Future<void> fetchAuthors() async {
    emit(AuthorsLoading());
    try {
      final authors = await _repository.getAllAuthors();
      emit(AuthorsLoaded(authors));
    } catch (e) {
      emit(AuthorsError(e.toString()));
    }
  }
}

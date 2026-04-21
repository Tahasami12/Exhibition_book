import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/author_repository.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'admin_authors_state.dart';

class AdminAuthorsCubit extends Cubit<AdminAuthorsState> {
  final AuthorRepository _authorRepository;

  AdminAuthorsCubit(this._authorRepository) : super(AdminAuthorsInitial());

  Future<void> fetchAuthors() async {
    emit(AdminAuthorsLoading());
    try {
      final authors = await _authorRepository.getAllAuthors();
      emit(AdminAuthorsLoaded(authors));
    } catch (e) {
      emit(AdminAuthorsError(e.toString()));
    }
  }

  Future<void> addAuthor(AuthorModel author) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.addAuthor(author);
      emit(AdminAuthorsActionSuccess('Author added successfully'));
      await fetchAuthors();
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
      await fetchAuthors();
    }
  }

  Future<void> updateAuthor(AuthorModel author) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.updateAuthor(author);
      emit(AdminAuthorsActionSuccess('Author updated successfully'));
      await fetchAuthors();
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
      await fetchAuthors();
    }
  }

  Future<void> deleteAuthor(String id) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.deleteAuthor(id);
      emit(AdminAuthorsActionSuccess('Author deleted successfully'));
      await fetchAuthors();
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
      await fetchAuthors();
    }
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exhibition_book/core/api/author_repository.dart';
import 'package:exhibition_book/features/home/data/models/author_model.dart';
import 'admin_authors_state.dart';

class AdminAuthorsCubit extends Cubit<AdminAuthorsState> {
  final AuthorRepository _authorRepository;

  AdminAuthorsCubit(this._authorRepository) : super(AdminAuthorsInitial());
  StreamSubscription? _subscription;

  Future<void> fetchAuthors() async {
    emit(AdminAuthorsLoading());
    _subscription?.cancel();
    _subscription = _authorRepository.getAuthorsStream().listen(
      (authors) => emit(AdminAuthorsLoaded(authors)),
      onError: (e) => emit(AdminAuthorsError(e.toString())),
    );
  }

  Future<void> addAuthor(AuthorModel author) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.addAuthor(author);
      emit(AdminAuthorsActionSuccess('Author added successfully'));
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
    }
  }

  Future<void> updateAuthor(AuthorModel author) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.updateAuthor(author);
      emit(AdminAuthorsActionSuccess('Author updated successfully'));
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
    }
  }

  Future<void> deleteAuthor(String id) async {
    emit(AdminAuthorsActionLoading());
    try {
      await _authorRepository.deleteAuthor(id);
      emit(AdminAuthorsActionSuccess('Author deleted successfully'));
    } catch (e) {
      emit(AdminAuthorsActionError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/author_repository.dart';
import 'authors_state.dart';

class AuthorsCubit extends Cubit<AuthorsState> {
  final AuthorRepository _repository;

  AuthorsCubit(this._repository) : super(AuthorsInitial());
  StreamSubscription? _subscription;

  Future<void> fetchAuthors() async {
    emit(AuthorsLoading());
    _subscription?.cancel();
    _subscription = _repository.getAuthorsStream().listen(
      (authors) => emit(AuthorsLoaded(authors)),
      onError: (e) => emit(AuthorsError(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

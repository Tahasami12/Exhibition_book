import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/data/models/book_model.dart';
import '../data/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repository) : super(FavoritesInitial());

  final FavoritesRepository _repository;

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      emit(FavoritesLoaded(_repository.getFavorites()));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void toggleFavorite(BookModel book) {
    try {
      final updatedFavorites = _repository.toggleFavorite(book);
      emit(FavoritesLoaded(updatedFavorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  void removeFavorite(String bookId) {
    try {
      final updatedFavorites = _repository.removeFavorite(bookId);
      emit(FavoritesLoaded(updatedFavorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String bookId) {
    if (state is FavoritesLoaded) {
      final currentFavorites = (state as FavoritesLoaded).favorites;
      return currentFavorites.any((book) => book.id == bookId);
    }

    return _repository.isFavorite(bookId);
  }
}

import '../models/favorite_model.dart';
import '../../home/data/models/book_model.dart';

class FavoritesRepository {
  final List<FavoriteModel> _favorites = [];

  List<FavoriteModel> getFavorites() {
    return List.unmodifiable(_favorites);
  }

  bool isFavorite(String bookId) {
    return _favorites.any((book) => book.id == bookId);
  }

  List<FavoriteModel> addFavorite(BookModel book) {
    if (!isFavorite(book.id)) {
      _favorites.add(FavoriteModel.fromBook(book));
    }
    return getFavorites();
  }

  List<FavoriteModel> removeFavorite(String bookId) {
    _favorites.removeWhere((book) => book.id == bookId);
    return getFavorites();
  }

  List<FavoriteModel> toggleFavorite(BookModel book) {
    if (isFavorite(book.id)) {
      return removeFavorite(book.id);
    }
    return addFavorite(book);
  }
}

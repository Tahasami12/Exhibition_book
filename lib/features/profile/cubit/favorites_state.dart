import '../models/favorite_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  FavoritesLoaded(this.favorites);

  final List<FavoriteModel> favorites;
}

class FavoritesError extends FavoritesState {
  FavoritesError(this.message);

  final String message;
}

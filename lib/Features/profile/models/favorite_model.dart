class FavoriteModel {
  String? title;
  double? price;
  String? coverURL;

  FavoriteModel(this.title, this.price, this.coverURL);
  FavoriteModel.fromJson({
    required String this.title,
    required double this.price,
    required String this.coverURL,
  });
}

class FavoriteModel {
  String? bookTitle;
  double? bookPrice;
  String? bookCoverURL;

  FavoriteModel(this.bookTitle, this.bookPrice, this.bookCoverURL);
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    bookTitle = json["bookTitle"];
    bookPrice = json["bookPrice"];
    bookCoverURL = json["bookCoverURL"];
  }
}

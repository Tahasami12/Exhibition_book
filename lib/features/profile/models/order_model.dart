
class OrderModel {
  int? booksCount;
  String? bookTitle;
  String? orderStatus;
  String? bookCoverURL;
  // OrderStatus? orderStatus;

  OrderModel.fromJson(Map<String, dynamic> json) {
    bookTitle = json["bookTitle"];
    booksCount = json["booksCount"];
    orderStatus = json["orderStatus"];
    bookCoverURL = json["bookCoverURL"];
  }
}

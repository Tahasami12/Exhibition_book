import 'package:exhibition_book/Features/profile/constants.dart';

class OrderModel {
  int? itemsCount;
  String? orderLabel;
  OrderStatus? status;
  String? coverURL;

  OrderModel.fromJson({
    this.orderLabel,
    this.itemsCount,
    this.status,
    this.coverURL,
  });
}

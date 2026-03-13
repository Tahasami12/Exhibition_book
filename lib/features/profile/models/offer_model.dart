class OfferModel {
  int? offerValue;
  String? offerCode;

  OfferModel({this.offerValue, this.offerCode});
  OfferModel.fromJson(Map<String, dynamic> json) {
    offerValue = json["offerValue"];
    offerCode = json["offerCode"];
  }
}

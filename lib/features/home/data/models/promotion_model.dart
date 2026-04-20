class PromotionModel {
  final String id;
  final String title;
  final String discount;
  final String imageUrl;

  PromotionModel({
    required this.id,
    required this.title,
    required this.discount,
    required this.imageUrl,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json, String id) {
    return PromotionModel(
      id: id,
      title: json['title'] ?? 'Special Offer',
      discount: json['discount'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
    );
  }
}

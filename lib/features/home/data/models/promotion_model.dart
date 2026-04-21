class PromotionModel {
  final String id;
  final String title;
  final String discount;
  final String imageUrl;
  final bool isActive;

  PromotionModel({
    required this.id,
    required this.title,
    required this.discount,
    required this.imageUrl,
    this.isActive = true,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json, String id) {
    dynamic activeRaw = json['isActive'];
    bool activeFlag = true; // default
    if (activeRaw is bool) {
      activeFlag = activeRaw;
    } else if (activeRaw is String) {
      activeFlag = activeRaw.toLowerCase() == 'true';
    }

    return PromotionModel(
      id: id,
      title: json['title'] ?? 'Special Offer',
      discount: json['discount'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      isActive: activeFlag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'discount': discount,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }
}

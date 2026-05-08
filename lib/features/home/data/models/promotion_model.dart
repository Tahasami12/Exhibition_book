class PromotionModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String discountAr;
  final String discountEn;
  final String imageUrl;
  final bool isActive;

  PromotionModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.discountAr,
    required this.discountEn,
    required this.imageUrl,
    this.isActive = true,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String title(bool isAr) => isAr ? titleAr : titleEn;
  String discount(bool isAr) => isAr ? discountAr : discountEn;

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
      titleAr: json['titleAr'] ?? json['title'] ?? 'عرض خاص',
      titleEn: json['titleEn'] ?? json['title'] ?? 'Special Offer',
      discountAr: json['discountAr'] ?? json['discount'] ?? '',
      discountEn: json['discountEn'] ?? json['discount'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      isActive: activeFlag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleAr': titleAr,
      'titleEn': titleEn,
      'discountAr': discountAr,
      'discountEn': discountEn,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }
}

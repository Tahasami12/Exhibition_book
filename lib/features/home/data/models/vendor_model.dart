class VendorModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String logoUrl;
  final double rating;
  final bool isBestVendor;

  VendorModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.logoUrl,
    required this.rating,
    required this.isBestVendor,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String name(bool isAr) => isAr ? nameAr : nameEn;

  factory VendorModel.fromFirestore(Map<String, dynamic> json, String id) {
    final dynamic rawRating = json['rating'];
    return VendorModel(
      id: id,
      nameAr: json['nameAr'] ?? json['name'] ?? 'بائع غير معروف',
      nameEn: json['nameEn'] ?? json['name'] ?? 'Unknown Vendor',
      logoUrl: json['logo'] ?? json['logoUrl'] ?? 'assets/images/vendor.png',
      rating: rawRating is num ? rawRating.toDouble() : 0,
      isBestVendor: json['isBestVendor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'logoUrl': logoUrl,
      'rating': rating,
      'isBestVendor': isBestVendor,
    };
  }
}

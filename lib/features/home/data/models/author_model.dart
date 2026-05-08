class AuthorModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String imageUrl;
  final String bioAr;
  final String bioEn;
  final int booksCount;

  AuthorModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.imageUrl,
    required this.bioAr,
    required this.bioEn,
    required this.booksCount,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String name(bool isAr) => isAr ? nameAr : nameEn;
  String bio(bool isAr) => isAr ? bioAr : bioEn;

  factory AuthorModel.fromFirestore(Map<String, dynamic> json, String id) {
    return AuthorModel(
      id: id,
      nameAr: json['nameAr'] ?? json['name'] ?? 'مؤلف غير معروف',
      nameEn: json['nameEn'] ?? json['name'] ?? 'Unknown Author',
      imageUrl: json['image'] ?? json['imageUrl'] ?? 'assets/images/author.png',
      bioAr: json['bioAr'] ?? json['bio'] ?? '',
      bioEn: json['bioEn'] ?? json['bio'] ?? '',
      booksCount: json['booksCount'] is num ? (json['booksCount'] as num).toInt() : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'imageUrl': imageUrl,
      'bioAr': bioAr,
      'bioEn': bioEn,
      'booksCount': booksCount,
    };
  }
}

class BookModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String authorAr;
  final String authorEn;
  final String? authorId;
  final String? vendorId;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final double rating;
  final String imageUrl;
  final String categoryAr;
  final String categoryEn;
  final int stock;
  final dynamic createdAt;

  BookModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.authorAr,
    required this.authorEn,
    this.authorId,
    this.vendorId,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.categoryAr,
    required this.categoryEn,
    this.stock = 0,
    this.createdAt,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String title(bool isAr) => isAr ? titleAr : titleEn;
  String author(bool isAr) => isAr ? authorAr : authorEn;
  String description(bool isAr) => isAr ? descriptionAr : descriptionEn;
  String category(bool isAr) => isAr ? categoryAr : categoryEn;

  factory BookModel.fromJson(Map<String, dynamic> json, String id) {
    return BookModel(
      id: id,
      titleAr: json['titleAr'] ?? json['title'] ?? '',
      titleEn: json['titleEn'] ?? json['title'] ?? '',
      authorAr: json['authorAr'] ?? json['author'] ?? 'مؤلف غير معروف',
      authorEn: json['authorEn'] ?? json['author'] ?? 'Unknown Author',
      authorId: json['authorId'],
      vendorId: json['vendorId'],
      descriptionAr: json['descriptionAr'] ?? json['description'] ?? '',
      descriptionEn: json['descriptionEn'] ?? json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      categoryAr: json['categoryAr'] ?? json['category'] ?? 'غير مصنف',
      categoryEn: json['categoryEn'] ?? json['category'] ?? 'Uncategorized',
      stock: json['stock'] ?? 0,
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleAr': titleAr,
      'titleEn': titleEn,
      'authorAr': authorAr,
      'authorEn': authorEn,
      'authorId': authorId,
      'vendorId': vendorId,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'categoryAr': categoryAr,
      'categoryEn': categoryEn,
      'stock': stock,
      'createdAt': createdAt,
    };
  }
}

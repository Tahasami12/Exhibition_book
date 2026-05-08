import '../../home/data/models/book_model.dart';

class FavoriteModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String authorAr;
  final String authorEn;
  final double price;
  final String imageUrl;
  final String descriptionAr;
  final String descriptionEn;
  final double rating;
  final String categoryAr;
  final String categoryEn;

  const FavoriteModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.authorAr,
    required this.authorEn,
    required this.price,
    required this.imageUrl,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.rating,
    required this.categoryAr,
    required this.categoryEn,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String title(bool isAr) => isAr ? titleAr : titleEn;
  String author(bool isAr) => isAr ? authorAr : authorEn;
  String description(bool isAr) => isAr ? descriptionAr : descriptionEn;
  String category(bool isAr) => isAr ? categoryAr : categoryEn;

  factory FavoriteModel.fromBook(BookModel book) {
    return FavoriteModel(
      id: book.id,
      titleAr: book.titleAr,
      titleEn: book.titleEn,
      authorAr: book.authorAr,
      authorEn: book.authorEn,
      price: book.price,
      imageUrl: book.imageUrl,
      descriptionAr: book.descriptionAr,
      descriptionEn: book.descriptionEn,
      rating: book.rating,
      categoryAr: book.categoryAr,
      categoryEn: book.categoryEn,
    );
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? '',
      titleAr: json['titleAr'] ?? json['title'] ?? '',
      titleEn: json['titleEn'] ?? json['title'] ?? '',
      authorAr: json['authorAr'] ?? json['author'] ?? 'غير معروف',
      authorEn: json['authorEn'] ?? json['author'] ?? 'Unknown',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      descriptionAr: json['descriptionAr'] ?? json['description'] ?? '',
      descriptionEn: json['descriptionEn'] ?? json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      categoryAr: json['categoryAr'] ?? json['category'] ?? 'غير مصنف',
      categoryEn: json['categoryEn'] ?? json['category'] ?? 'Uncategorized',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'authorAr': authorAr,
      'authorEn': authorEn,
      'price': price,
      'imageUrl': imageUrl,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'rating': rating,
      'categoryAr': categoryAr,
      'categoryEn': categoryEn,
    };
  }

  BookModel toBook() {
    return BookModel(
      id: id,
      titleAr: titleAr,
      titleEn: titleEn,
      authorAr: authorAr,
      authorEn: authorEn,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      price: price,
      rating: rating,
      imageUrl: imageUrl,
      categoryAr: categoryAr,
      categoryEn: categoryEn,
    );
  }
}

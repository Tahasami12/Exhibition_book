class CartItem {
  final String id;
  final String titleAr;
  final String titleEn;
  final String authorAr;
  final String authorEn;
  final double price;
  final int quantity;
  final String imageUrl;

  const CartItem({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.authorAr,
    required this.authorEn,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  // ─── Localized Getters ───────────────────────────────────────────────────
  String title(bool isAr) => isAr ? titleAr : titleEn;
  String author(bool isAr) => isAr ? authorAr : authorEn;

  CartItem copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    String? authorAr,
    String? authorEn,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      authorAr: authorAr ?? this.authorAr,
      authorEn: authorEn ?? this.authorEn,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
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
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromJson(Map<dynamic, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      titleAr: json['titleAr'] ?? json['title'] ?? '',
      titleEn: json['titleEn'] ?? json['title'] ?? '',
      authorAr: json['authorAr'] ?? json['author'] ?? '',
      authorEn: json['authorEn'] ?? json['author'] ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  double get total => price * quantity;
}

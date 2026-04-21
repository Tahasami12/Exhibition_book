class BookModel {
  final String id;
  final String title;
  final String author;
  final String? authorId;
  final String? vendorId;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;
  final int stock;
  final dynamic createdAt;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.authorId,
    this.vendorId,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
    this.stock = 0,
    this.createdAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String id) {
    return BookModel(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? 'Unknown',
      authorId: json['authorId'],
      vendorId: json['vendorId'],
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      category: json['category'] ?? 'Uncategorized',
      stock: json['stock'] ?? 0,
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'authorId': authorId,
      'vendorId': vendorId,
      'description': description,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'category': category,
      'stock': stock,
      'createdAt': createdAt,
    };
  }
}

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String id) {
    return BookModel(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? 'Unknown',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      category: json['category'] ?? 'Uncategorized',
    );
  }
}

import '../../home/data/models/book_model.dart';

class FavoriteModel {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final String category;

  const FavoriteModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.category,
  });

  factory FavoriteModel.fromBook(BookModel book) {
    return FavoriteModel(
      id: book.id,
      title: book.title,
      author: book.author,
      price: book.price,
      imageUrl: book.imageUrl,
      description: book.description,
      rating: book.rating,
      category: book.category,
    );
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? 'Unknown',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'assets/images/book.png',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      category: json['category'] ?? 'Uncategorized',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'category': category,
    };
  }

  BookModel toBook() {
    return BookModel(
      id: id,
      title: title,
      author: author,
      description: description,
      price: price,
      rating: rating,
      imageUrl: imageUrl,
      category: category,
    );
  }
}

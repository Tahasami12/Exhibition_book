class AuthorModel {
  final String id;
  final String name;
  final String imageUrl;
  final String bio;
  final int booksCount;

  AuthorModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.booksCount,
  });

  factory AuthorModel.fromFirestore(Map<String, dynamic> json, String id) {
    return AuthorModel(
      id: id,
      name: json['name'] ?? 'Unknown Author',
      imageUrl: json['image'] ?? json['imageUrl'] ?? 'assets/images/author.png',
      bio: json['bio'] ?? '',
      booksCount: json['booksCount'] is num ? (json['booksCount'] as num).toInt() : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'bio': bio,
      'booksCount': booksCount,
    };
  }
}

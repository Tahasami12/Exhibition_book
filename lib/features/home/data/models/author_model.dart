class AuthorModel {
  final String id;
  final String name;
  final String role;
  final String imageUrl;

  AuthorModel({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  factory AuthorModel.fromFirestore(Map<String, dynamic> json, String id) {
    return AuthorModel(
      id: id,
      name: json['name'] ?? 'Unknown Author',
      role: json['role'] ?? 'Writer',
      imageUrl: json['imageUrl'] ?? 'assets/images/author.png',
    );
  }
}

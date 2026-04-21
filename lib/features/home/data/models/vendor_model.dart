class VendorModel {
  final String id;
  final String name;
  final String logoUrl;
  final double rating;
  final bool isBestVendor;

  VendorModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rating,
    required this.isBestVendor,
  });

  factory VendorModel.fromFirestore(Map<String, dynamic> json, String id) {
    final dynamic rawRating = json['rating'];
    return VendorModel(
      id: id,
      name: json['name'] ?? 'Unknown Vendor',
      logoUrl: json['logo'] ?? json['logoUrl'] ?? 'assets/images/vendor.png',
      rating: rawRating is num ? rawRating.toDouble() : 0,
      isBestVendor: json['isBestVendor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'rating': rating,
      'isBestVendor': isBestVendor,
    };
  }
}

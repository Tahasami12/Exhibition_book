class VendorModel {
  final String id;
  final String name;
  final String logoUrl;

  VendorModel({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  factory VendorModel.fromFirestore(Map<String, dynamic> json, String id) {
    return VendorModel(
      id: id,
      name: json['name'] ?? 'Unknown Vendor',
      logoUrl: json['logo'] ?? json['logoUrl'] ?? 'assets/images/vendor.png',
    );
  }
}

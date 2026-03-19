class DeliveryAddress {
  final String name;
  final String governorate;
  final String city;

  const DeliveryAddress({
    required this.name,
    required this.governorate,
    required this.city,
  });

  String get displayTitle => '$name - $city';
  String get fullAddress => '$name, $city, $governorate';

  DeliveryAddress copyWith({
    String? name,
    String? governorate,
    String? city,
  }) {
    return DeliveryAddress(
      name: name ?? this.name,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
    );
  }
}

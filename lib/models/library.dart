class Library {
  final int? id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String district;

  Library({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.district,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'district': district,
    };
  }

  factory Library.fromMap(Map<String, dynamic> map) {
    return Library(
      id: map['id'],
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      district: map['district'],
    );
  }
}
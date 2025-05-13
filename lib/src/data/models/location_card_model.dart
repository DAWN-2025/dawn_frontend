class LocationCardModel {
  final int id;
  final String name;
  final String locationImage;
  final String address;
  final bool visited;

  LocationCardModel({
    required this.id,
    required this.name,
    required this.locationImage,
    required this.address,
    this.visited = false,
  });

  factory LocationCardModel.fromJson(Map<String, dynamic> json) {
    return LocationCardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      locationImage: json['locationImage'] ?? '',
      address: json['address'] ?? 'No Address',
      visited: json['visited'] ?? false,
    );
  }
}

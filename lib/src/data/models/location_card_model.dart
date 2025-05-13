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
    // 이미지 URL 유효성 검사 함수
    String _getImageUrl(Map<String, dynamic> json) {
      if (json.containsKey('locationSimpleImage')) {
        return json['locationSimpleImage'] ?? '';
      } else if (json.containsKey('locationImage')) {
        return json['locationImage'] ?? '';
      }
      return '';
    }

    return LocationCardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      locationImage: _getImageUrl(json),  // 수정된 부분
      address: json['address'] ?? 'No Address',
      visited: json['visited'] ?? false,
    );
  }
}

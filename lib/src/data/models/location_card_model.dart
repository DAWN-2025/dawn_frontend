class LocationCardModel {
  final int id;
  final String name;
  final String nameEng;
  final String locationSimpleImage;
  final String address;
  final bool visited;
  final List<String> keywords;

  LocationCardModel({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.locationSimpleImage,
    required this.address,
    this.visited = false,
    required this.keywords,
  });

  // 팩토리 생성자를 통한 객체 생성
  factory LocationCardModel.fromMap(Map<String, dynamic> map) {
    return LocationCardModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? 'Unknown',
      nameEng: map['nameEng'] ?? 'Unknown',
      locationSimpleImage: map['locationSimpleImage'] ?? '',
      address: map['address'] ?? 'No address',
      visited: map['visited'] ?? false,
      keywords: _parseKeywords(map['keywords']),
    );
  }

  // 키워드 목록 변환
  static List<String> _parseKeywords(dynamic keywords) {
    if (keywords is List) {
      return keywords
          .map((item) => (item is Map && item['keyword'] is String) ? item['keyword'] as String : 'Unknown')
          .toList();
    }
    return [];
  }

  // 데이터를 가공하여 출력하는 메서드
  @override
  String toString() {
    return 'LocationCardModel(id: $id, name: $name, address: $address, visited: $visited, image: $locationSimpleImage)';
  }

  // 객체 복사 메서드
  LocationCardModel copyWith({bool? visited}){
    return LocationCardModel(
      id: this.id,
      name: this.name,
      nameEng: this.nameEng,
      locationSimpleImage: this.locationSimpleImage,
      address: this.address,
      visited: visited ?? this.visited,
      keywords: this.keywords,
    );
  }
}

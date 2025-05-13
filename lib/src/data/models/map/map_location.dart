import 'keyword.dart';

class MapLocationDTO {
  final int id;
  final String name;
  final String nameEng;
  final String imageUrl;
  final String address;
  final List<KeywordDTO> keywords;

  MapLocationDTO({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.imageUrl,
    required this.address,
    required this.keywords,
  });

  factory MapLocationDTO.fromJson(Map<String, dynamic> json) {
    return MapLocationDTO(
      id: json['id'] as int,
      name: json['name'] ?? '',
      nameEng: json['nameEng'] ?? '',
      imageUrl: json['locationSimpleImage'] ?? '',
      address: json['address'] ?? '',
      keywords: (json['keywords'] as List<dynamic>)
          .map((k) => KeywordDTO.fromJson(k))
          .toList(),
    );
  }
}

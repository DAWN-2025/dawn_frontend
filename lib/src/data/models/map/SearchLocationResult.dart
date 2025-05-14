import 'keyword.dart';

class SearchLocationResult {
  final int id;
  final String name;
  final String nameEng;
  final String locationSimpleImage;
  final String address;
  final List<KeywordDTO> keywords;

  SearchLocationResult({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.locationSimpleImage,
    required this.address,
    required this.keywords,
  });

  factory SearchLocationResult.fromJson(Map<String, dynamic> json) {
    return SearchLocationResult(
      id: json['id'],
      name: json['name'] ?? '',
      nameEng: json['nameEng'] ?? '',
      locationSimpleImage: json['locationSimpleImage'] ?? '',
      address: json['address'] ?? '',
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => KeywordDTO.fromJson(e))
          .toList() ??
          [],
    );
  }
}

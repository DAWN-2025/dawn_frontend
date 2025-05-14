import 'keyword.dart';

class SearchEventResult {
  final int id;
  final String name;
  final String nameEng;
  final String eventImage;
  final List<KeywordDTO> keywords;

  SearchEventResult({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.eventImage,
    required this.keywords,
  });

  factory SearchEventResult.fromJson(Map<String, dynamic> json) {
    return SearchEventResult(
      id: json['id'],
      name: json['name'] ?? '',
      nameEng: json['nameEng'] ?? '',
      eventImage: json['eventImage'] ?? '',
      keywords:
          (json['keywords'] as List<dynamic>?)
              ?.map((e) => KeywordDTO.fromJson(e))
              .toList() ??
          [],
    );
  }
}

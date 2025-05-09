class Episode {
  final int id;
  final Map<String, String> name;
  final String eventImage;
  final List<Map<String, String>> keywords;

  Episode({
    required this.id,
    required this.name,
    required this.eventImage,
    required this.keywords,
  });

  // JSON -> Dart 객체로 변환
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
      eventImage: json['eventImage'],
      keywords: List<Map<String, String>>.from(
        (json['keywords'] as List).map(
          (k) => Map<String, String>.from(k['keyword']),
        ),
      ),
      // [{ "en": "Korea", "ko": "대한민국" }, ...]
    );
  }

  // 현재 locale에 맞는 이름과 키워드 반환
  String getNameByLocale(String locale) => name[locale] ?? name['en']!;

  List<String> getKeywordsByLocale(String locale) =>
      keywords.map((k) => k[locale] ?? k['en']!).toList();
}

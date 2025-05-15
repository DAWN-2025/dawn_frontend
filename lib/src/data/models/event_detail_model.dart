class EventDetail {
  final int id;
  final String name;
  final String shortInfo;
  final String background;
  final String progress;
  final String meaning;
  final String date;
  final String nation;
  final String category;
  final String nationEng;
  final String categoryEng;
  final String image;
  final List<String> keywords;

  EventDetail({
    required this.id,
    required this.name,
    required this.shortInfo,
    required this.background,
    required this.progress,
    required this.meaning,
    required this.date,
    required this.nation,
    required this.category,
    required this.nationEng,
    required this.categoryEng,
    required this.image,
    required this.keywords,
  });

  // JSON 데이터를 모델로 변환
  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: _parseInt(json['id']),
      name: _formatString(json['nameEng'], 'Unknown'),
      shortInfo: _formatString(json['shortInfoEng'], 'No short info'),
      background: _formatString(json['backgroundEng'], 'No background info'),
      progress: _formatString(json['progressEng'], 'No progress info'),
      meaning: _formatString(json['meaningEng'], 'No meaning info'),
      date: _formatString(json['date'], 'No date'),
      nation: _formatString(json['nation'], 'No nation'),
      category: _formatString(json['category'], 'No category'),
      nationEng: _formatString(json['nationEng'], 'No English nation'),
      categoryEng: _formatString(json['categoryEng'], 'No English category'),
      image: _formatString(json['image'], 'assets/images/default.jpg'),
      keywords: _parseKeywords(json['keywords']),
    );
  }

 // 개행 문자 처리 메서드 (정규 표현식 사용)
  static String _formatString(String? value, String defaultValue) {
    if (value == null || value.isEmpty) return defaultValue;
    // \\n을 \n으로 변환하여 실제 개행 처리
    return value.replaceAll(RegExp(r'\\n'), '\n');
  }

  // 키워드 리스트 처리 메서드
  static List<String> _parseKeywords(dynamic keywords) {
    if (keywords is List) {
      return keywords
          .map((item) => (item is Map && item['keywordEng'] is String) ? item['keywordEng'] as String : 'Unknown')
          .toList();
    }
    return [];
  }

  // 숫자 파싱 메서드
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  @override
  String toString() {
    return 'EventDetail(id: $id, name: $name, shortInfo: $shortInfo, keywords: $keywords)';
  }
}

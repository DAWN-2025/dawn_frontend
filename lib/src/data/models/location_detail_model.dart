class LocationDetail {
  final int id;
  final String name;
  final String address;
  final int eventId;
  final String image;
  final String shortInfo;
  final String historicInfo;
  final String etiquette;
  final String openTime;
  final String closeTime;
  final String phoneNum;
  final List<String> keywords;
  final String exhibitionTime;
  final String available;
  final String translate;

  LocationDetail({
    required this.id,
    required this.name,
    required this.address,
    required this.eventId,
    required this.image,
    required this.shortInfo,
    required this.historicInfo,
    required this.etiquette,
    required this.openTime,
    required this.closeTime,
    required this.phoneNum,
    required this.keywords,
    required this.exhibitionTime,
    required this.available,
    required this.translate,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    List<String> parsedKeywords = [];
    if (json['keywords'] != null && json['keywords'] is List) {
      parsedKeywords =
          (json['keywords'] as List)
              .map((item) => item['keywordEng']?.toString() ?? '')
              .where((keyword) => keyword.isNotEmpty)
              .toList();
    }
    return LocationDetail(
      id: json['id'],
      name: json['nameEng'],
      address: json['addressEng'],
      eventId: json['eventId'],
      image: json['image'],
      shortInfo: json['shortInfoEng'],
      historicInfo: json['historicInfoEng'],
      etiquette: _formatString(json['etiquetteEng'], 'No etiquette info'),
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      phoneNum: json['phoneNum'],
      keywords: parsedKeywords,
      exhibitionTime: json['exhibitionTime'],
      available: json['available'],
      translate: json['translate'],
    );
  }

  // 개행 문자 처리 메서드 (정규 표현식 사용)
  static String _formatString(String? value, String defaultValue) {
    if (value == null || value.isEmpty) return defaultValue;
    // \\n을 \n으로 변환하여 실제 개행 처리
    return value.replaceAll(RegExp(r'\\n'), '\n');
  }
}

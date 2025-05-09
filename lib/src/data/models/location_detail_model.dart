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
              .map((item) => item['keyword']?.toString() ?? '')
              .where((keyword) => keyword.isNotEmpty)
              .toList();
    }
    return LocationDetail(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      eventId: json['eventId'],
      image: json['image'],
      shortInfo: json['shortInfo'],
      historicInfo: json['historicInfo'],
      etiquette: json['etiquette'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      phoneNum: json['phoneNum'],
      keywords: parsedKeywords,
      exhibitionTime: json['exhibitionTime'],
      available: json['available'],
      translate: json['translate'],
    );
  }
}

class LocationDetail {
  final int id;
  final String name;
  final String address;
  final String image;
  final String shortInfo;
  final String historicInfo;
  final String etiquette;
  final String openTime;
  final String closeTime;
  final String exhibitionTime;
  final String phoneNum;
  final List<String> keywords;
  final String available;
  final String translate;

  LocationDetail({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.shortInfo,
    required this.historicInfo,
    required this.etiquette,
    required this.openTime,
    required this.closeTime,
    required this.exhibitionTime,
    required this.phoneNum,
    required this.keywords,
    required this.available,
    required this.translate,
  });

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    List<String> parsedKeywords = [];
    if (json['keywords'] != null && json['keywords'] is List) {
      parsedKeywords = (json['keywords'] as List)
          .map((item) => item['keyword']?.toString() ?? '')
          .where((keyword) => keyword.isNotEmpty)
          .toList();
    }

    return LocationDetail(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Location',
      address: json['address'] ?? 'Unknown Address',
      image: json['image'] ?? 'assets/images/default.jpg',
      shortInfo: json['shortInfo'] ?? '',
      historicInfo: json['historicInfo'] ?? '',
      etiquette: json['etiquette'] ?? '',
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      exhibitionTime: json['exhibitionTime'] ?? '',
      phoneNum: json['phoneNum'] ?? '',
      keywords: parsedKeywords,
      available: json['available'] ?? 'N',
      translate: json['translate'] ?? 'N',
    );
  }

  /// 포맷된 Description 반환
  String getFormattedDescription() {
    final List<String> descriptionParts = [];

    // Address
    if (address.isNotEmpty) {
      descriptionParts.add("Address  |  $address");
    }

    // Hours (Open and Close)
    if (openTime.isNotEmpty && closeTime.isNotEmpty) {
      descriptionParts.add("Hours  |  Open ⋅ Closes $closeTime");
    }

    // Phone
    if (phoneNum.isNotEmpty) {
      descriptionParts.add("Phone  |  $phoneNum");
    }

    // Exhibition Tour
    if (exhibitionTime.isNotEmpty) {
      descriptionParts.add("Exhibition tour  |  $exhibitionTime");
    }

    // Available Facilities
    if (available == "Y") {
      descriptionParts.add("Available  |  wheelchair, baby stroller, elevator");
    }

    // Translation Options
    if (translate == "Y") {
      descriptionParts.add("Translate  |  English, Japanese");
    }

    // Join the description parts into a single formatted string
    return descriptionParts.join("\n");
  }
}

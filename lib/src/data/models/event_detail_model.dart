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
  final String nameEng;
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
    required this.nameEng,
    required this.nationEng,
    required this.categoryEng,
    required this.image,
    required this.keywords,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: _parseInt(json['id']),
      name: json['name'] ?? 'Unknown',
      shortInfo: json['shortInfo'] ?? 'No short info',
      background: json['background'] ?? 'No background info',
      progress: json['progress'] ?? 'No progress info',
      meaning: json['meaning'] ?? 'No meaning info',
      date: json['date'] ?? 'No date',
      nation: json['nation'] ?? 'No nation',
      category: json['category'] ?? 'No category',
      nameEng: json['nameEng'] ?? 'No English name',
      nationEng: json['nationEng'] ?? 'No English nation',
      categoryEng: json['categoryEng'] ?? 'No English category',
      image: json['image'] ?? 'assets/images/default.jpg',
      keywords: (json['keywords'] as List?)
              ?.map((item) => item['keyword'] as String? ?? 'Unknown')
              .toList() ??
          [],
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}

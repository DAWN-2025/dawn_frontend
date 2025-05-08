class EventDetail {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final EventImages images;
  final List<Section> sections;
  final List<Location> locations;

  EventDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.images,
    required this.sections,
    required this.locations,
  });

  /// copyWith 메서드 추가
  EventDetail copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
    EventImages? images,
    List<Section>? sections,
    List<Location>? locations,
  }) {
    return EventDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      sections: sections ?? this.sections,
      locations: locations ?? this.locations,
    );
  }

  /// fromJson 메서드 수정
  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      id: json['id']?.toString() ?? 'Unknown ID', // 안전 처리
      title: json['title'] ?? 'No Title', // 기본값 추가
      description: json['description'] ?? 'No Description', // 기본값 추가
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      images: EventImages.fromJson(json['images'] ?? {}),
      sections: (json['sections'] as List?)
              ?.map((item) => Section.fromJson(item))
              .toList() ??
          [],
      locations: (json['locations'] as List?) // 위치 정보 추가
              ?.map((item) => Location.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class EventImages {
  final String header;
  final String bodyImage;

  EventImages({required this.header, required this.bodyImage});

  factory EventImages.fromJson(Map<String, dynamic> json) {
    return EventImages(
      header: json['header'] ?? 'assets/images/default_header.jpg', // 기본값
      bodyImage: json['bodyImage'] ?? 'assets/images/default_body.jpg', // 기본값
    );
  }
}

class Section {
  final String header;
  final String body;

  Section({required this.header, required this.body});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      header: json['header'] ?? 'No Header', // 기본값 추가
      body: json['body'] ?? 'No Content', // 기본값 추가
    );
  }
}

class Location {
  final String name;
  final String address;
  final String image;
  final bool visited;

  Location({
    required this.name,
    required this.address,
    required this.image,
    required this.visited,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? 'Unknown Location',
      address: json['address'] ?? 'No Address',
      image: json['image'] ?? 'assets/images/default_image.jpg',
      visited: json['visited'] ?? false,
    );
  }
}

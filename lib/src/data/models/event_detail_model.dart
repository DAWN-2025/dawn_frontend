class EventDetail {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final List<Section> sections;
  final EventImages images;

  EventDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.sections,
    required this.images,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        tags: List<String>.from(json['tags']),
        sections: (json['sections'] as List)
            .map((e) => Section.fromJson(e))
            .toList(),
        images: EventImages.fromJson(json['images']),
      );
}

class Section {
  final String header;
  final String body;

  Section({required this.header, required this.body});

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        header: json['header'],
        body: json['body'],
      );
}

class EventImages {
  final String header;
  final String bodyImage;

  EventImages({required this.header, required this.bodyImage});

  factory EventImages.fromJson(Map<String, dynamic> json) => EventImages(
        header: json['header'],
        bodyImage: json['statistics'],
      );
}

class LocationCardModel {
  final int locationId;
  final String name;
  final String address;
  final String image;
  final List<String> keywords;
  final bool visited;

  LocationCardModel({
    required this.locationId,
    required this.name,
    required this.address,
    required this.image,
    required this.keywords,
    required this.visited,
  });

  factory LocationCardModel.fromJson(Map<String, dynamic> json, List<int> visitedLocationSeqs) {
    print("Parsing LocationCardModel: ${json['id']} - ${json['name']}");

    final int locationId = json['id'] ?? 0;
    final bool isVisited = visitedLocationSeqs.contains(locationId);
    return LocationCardModel(
      locationId: locationId,
      name: json['name'] ?? 'Unknown Location',
      address: json['address'] ?? 'No Address',
      image: json['locationImage'] ?? 'assets/images/default.jpg',
      keywords: (json['keywords'] as List?)
              ?.map((item) => item['keyword'].toString())
              .toList() ??
          [],
      visited: isVisited,
    );
  }
}

class LocationCardModel {
  final String name;
  final String address;
  // final double latitude;
  // final double longitude;
  bool visited;

  LocationCardModel({
    required this.name,
    required this.address,
    // required this.latitude,
    // required this.longitude,
    this.visited = false
  });

  void toggleVisited() {
    visited = !visited;
  }
}

import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class LocationCardViewModel {
  final LocationCardModel model;

  LocationCardViewModel({required this.model});

  int get id => model.id;
  String get name => model.name;
  String get address => model.address;
  String get image => model.image;
  List<String> get keywords => model.keywords;
  bool get visited => model.visited;
}

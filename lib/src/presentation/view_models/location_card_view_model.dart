import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';

class LocationCardViewModel extends ChangeNotifier {
  final LocationCardModel model;

  LocationCardViewModel({required this.model});

  bool get visited => model.visited;

  void toggleVisited() {
    model.toggleVisited();
    notifyListeners();
  }
}

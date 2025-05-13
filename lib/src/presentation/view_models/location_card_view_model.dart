import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/domain/repositories/location_card_repository.dart';

class LocationCardViewModel extends ChangeNotifier {
  final LocationCardRepository _repository = LocationCardRepository();
  List<LocationCardModel> locationCards = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchEventLocations(int eventId) async {
    isLoading = true;
    notifyListeners();
    try {
      locationCards = await _repository.fetchEventLocations(eventId);
      print('Loaded ${locationCards.length} location cards');
    } catch (e) {
      errorMessage = 'Failed to load locations: $e';
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }

    void clearLocations() {
    locationCards = [];
    notifyListeners();
  }
  }
}

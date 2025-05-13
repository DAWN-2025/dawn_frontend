import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/domain/repositories/location_card_repository.dart';

class LocationCardViewModel extends ChangeNotifier {
  final LocationCardRepository _repository = LocationCardRepository();
  
  // LocationCardModel 자체를 필드로 사용
  LocationCardModel? locationCard;
  List<LocationCardModel> locationCards = [];
  bool isLoading = false;
  String? errorMessage;

  LocationCardViewModel({this.locationCard});

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
  }

  void clearLocations() {
    locationCards = [];
    notifyListeners();
  }

  Future<bool> isLocationVisited(int locationSeq, int userSeq) async {
    try {
      final visited = await _repository.checkVisited(locationSeq, userSeq);
      if (locationCard != null) {
        locationCard = LocationCardModel(
          id: locationCard!.id,
          name: locationCard!.name,
          locationImage: locationCard!.locationImage,
          address: locationCard!.address,
          visited: visited,
        );
      }
      notifyListeners();
      return visited;
    } catch (e) {
      print('Error checking visited status: $e');
      return false;
    }
  }
}

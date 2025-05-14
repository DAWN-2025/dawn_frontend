import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/domain/repositories/location_card_repository.dart';

class LocationCardViewModel extends ChangeNotifier {
  final LocationCardRepository _repository = LocationCardRepository();
  List<LocationCardModel> locationCards = [];
  bool isLoading = false;
  String? errorMessage;

  // 이벤트 장소 목록 가져오기 (방문 여부 반영)
  Future<void> fetchEventLocations(int eventId) async {
    isLoading = true;
    notifyListeners();
    try {
      locationCards = await _repository.fetchEventLocations(eventId);
    } catch (e) {
      errorMessage = 'Failed to load location cards: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

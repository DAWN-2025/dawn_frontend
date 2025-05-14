import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/domain/repositories/location_card_repository.dart';

class LocationCardViewModel extends ChangeNotifier {
  final LocationCardRepository _repository = LocationCardRepository();

  LocationCardModel? locationCard;
  List<LocationCardModel> locationCards = [];
  bool isLoading = false;
  String? errorMessage;

  LocationCardViewModel({this.locationCard});

  // 장소 카드 목록 가져오기
  Future<void> fetchEventLocations(int eventId) async {
  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    locationCards = await _repository.loadEventLocations(eventId);

    if (locationCards.isEmpty) {
      errorMessage = 'No location cards found';
      print(errorMessage);
    } else {
      print('Loaded ${locationCards.length} location cards');
    }
  } catch (e) {
    errorMessage = 'Failed to load locations: $e';
    print('Error: $errorMessage');
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  // 방문 여부 확인
  Future<bool> isLocationVisited(int locationSeq, int userSeq) async {
    try {
      // Repository에서 방문 여부 확인
      final bool visited = await _repository.checkVisited(locationSeq, userSeq);
      
      // LocationCard가 없는 경우 대비
      if (locationCard == null) {
        print('Location card not set.');
        return false;
      }

      // 방문 여부 업데이트
      locationCard = locationCard!.copyWith(visited: visited);

      print('Location ${locationCard!.name} visited status: $visited');
      notifyListeners();
      return visited;
    } catch (e) {
      errorMessage = 'Error checking visited status: $e';
      print('Error: $errorMessage');
      return false;
    }
  }

  // 장소 목록 초기화
  void clearLocations() {
    locationCards = [];
    notifyListeners();
  }
}

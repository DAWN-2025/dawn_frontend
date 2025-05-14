import 'package:dawn_frontend/src/data/models/location_card_model.dart';
import 'package:dawn_frontend/src/data/services/location_service.dart';

class LocationCardRepository {
  final LocationService _locationService = LocationService();

  // 이벤트에 해당하는 장소 카드 목록 가져오기 (방문 여부 포함)
  Future<List<LocationCardModel>> fetchEventLocations(int eventId) async {
    try {
      // 1. 모든 장소 카드 가져오기
      final List<LocationCardModel> locations = await _locationService.fetchEventLocations(eventId);
      
      // 2. 방문 여부 가져오기
      final Set<int> visitedSeqs = await _locationService.fetchVisitedLocationSeqs();

      // 3. 방문 여부를 반영하여 새로운 모델로 업데이트
      return locations.map((location) {
        bool isVisited = visitedSeqs.contains(location.id);
        return location.copyWith(visited: isVisited);  // copyWith 사용
      }).toList();
    } catch (e) {
      print('Error fetching event locations: $e');
      return [];
    }
  }
}

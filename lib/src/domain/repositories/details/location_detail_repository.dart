import 'package:dawn_frontend/src/data/services/location_service.dart';
import 'package:dawn_frontend/src/data/models/location_detail_model.dart';
import 'package:dawn_frontend/src/core/utils/log.dart';

class LocationDetailRepository {
  final LocationService _locationService = LocationService();

  // 장소 상세 정보 가져오기 (Service 호출)
  Future<LocationDetail?> getLocationDetail(int locationId) async {
    try {
      // LocationService를 통해 데이터 가져오기
      LocationDetail? detail = await _locationService.fetchLocationDetail(locationId);

      if (detail != null) {
        debugLog('LocationDetailRepository: 장소 상세 정보 로드 성공');
        return detail;
      } else {
        debugLog('LocationDetailRepository: 장소 상세 정보 없음');
        return null;
      }
    } catch (e) {
      debugLog('LocationDetailRepository: 오류 발생 - $e');
      return null;
    }
  }
}

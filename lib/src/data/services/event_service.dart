import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/clients/dio_client.dart';
import 'package:dawn_frontend/src/data/models/event_detail_model.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import '../../core/utils/log.dart';

class EventService {
  final Dio _dio;

  EventService() : _dio = DioClient().dio;

  // JWT 토큰을 가져와 헤더로 설정
  Future<Map<String, String>> _getAuthHeader() async {
    final token = await SecureStorage.getJwt();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }

  // 이벤트 상세 정보 가져오기
  Future<EventDetail> fetchEventDetail(int eventId) async {
    try {
      final headers = await _getAuthHeader();
      final response = await _dio.get(
        '/event/viewEventInfo',
        queryParameters: {'id': eventId},
        options: Options(headers: headers),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('이벤트 상세 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        return EventDetail.fromJson(response.data);
      } else {
        debugLog('이벤트 상세 정보 가져오기 실패');
        throw Exception('Failed to load event detail');
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      throw Exception('Failed to load event details: ${e.message}');
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      throw Exception('Error fetching event details: $e');
    }
  }
}

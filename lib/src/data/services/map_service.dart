import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';
import '../models/map/map_location.dart';

class MapService {
  final Dio _dio;

  MapService() : _dio = DioClient().dio;

  Future<List<MapLocationDTO>> fetchLocationList() async {
    try {
      // JWT 토큰 불러오기
      final token = await SecureStorage.getJwt();
      if (token == null) {
        debugLog('JWT 토큰이 없습니다.');
        return [];
      }

      // API 호출
      final response = await _dio.get(
        '/location/list',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('전체 응답 데이터: ${response.data}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((item) => MapLocationDTO.fromJson(item))
            .toList();
      } else {
        debugLog('예상치 못한 응답 형식입니다.');
        return [];
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      debugLog('응답 내용: ${e.response?.data}');
      return [];
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return [];
    }
  }
}
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';

class SearchService {
  final Dio _dio = DioClient().dio;

  /// 응답을 구조화하지 않고 Raw JSON만 출력 (for debugging)
  Future<void> searchByKeyword({
    required String keyword,
    required String jwtToken,
  }) async {
    try {
      debugLog('요청 keyword: $keyword');
      debugLog('요청 Authorization 헤더: Bearer $jwtToken');

      final response = await _dio.get(
        '/location/viewLocationBySearch',
        queryParameters: {'keyword': keyword},
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      // 전체 Raw 응답 출력
      debugLog('검색 응답 상태 코드: ${response.statusCode}');
      debugLog('검색 응답 원본: ${jsonEncode(response.data)}');
    } on DioException catch (e) {
      debugLog('검색 요청 실패: ${e.response?.statusCode} - ${e.response?.data}');
    } catch (e) {
      debugLog('알 수 없는 오류: $e');
    }
  }

  Future<void> searchEventByKeyword({
    required String keyword,
    required String jwtToken,
  }) async {
    try {
      debugLog('요청 keyword: $keyword');
      debugLog('요청 Authorization 헤더: Bearer $jwtToken');

      final response = await _dio.get(
        '/event/viewEventBySearch',
        queryParameters: {'keyword': keyword},
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugLog('이벤트 검색 응답 상태 코드: ${response.statusCode}');
      debugLog('이벤트 검색 응답 원본: ${jsonEncode(response.data)}');
    } on DioException catch (e) {
      debugLog('이벤트 검색 요청 실패: ${e.response?.statusCode} - ${e.response?.data}');
    } catch (e) {
      debugLog('알 수 없는 오류: $e');
    }
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';

class SearchService {
  final Dio _dio = DioClient().dio;

  Future<List<dynamic>> searchByKeyword({
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

      debugLog('검색 응답 상태 코드: ${response.statusCode}');
      debugLog('검색 응답 원본: ${jsonEncode(response.data)}');

      return response.data as List<dynamic>; // 데이터 반환
    } on DioException catch (e) {
      debugLog('검색 요청 실패: ${e.response?.statusCode} - ${e.response?.data}');
      return []; // 예외 발생 시 빈 리스트 반환
    } catch (e) {
      debugLog('알 수 없는 오류: $e');
      return []; // 예외 발생 시 빈 리스트 반환
    }
  }

  Future<List<dynamic>> searchEventByKeyword({
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

      return response.data as List<dynamic>;
    } on DioException catch (e) {
      debugLog('이벤트 검색 요청 실패: ${e.response?.statusCode} - ${e.response?.data}');
      return [];
    } catch (e) {
      debugLog('알 수 없는 오류: $e');
      return [];
    }
  }
}

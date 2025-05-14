import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';
import '../models/location_card_model.dart';
import '../models/location_detail_model.dart';

class LocationService {
  final Dio _dio;

  LocationService() : _dio = DioClient().dio;

  // JWT 토큰을 가져와 헤더로 설정
  Future<Map<String, String>> _getAuthHeader() async {
    final token = await SecureStorage.getJwt();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }

  // Firebase에서 userUid를 가져오기
  Future<String?> getUserUidFromFirebase() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      
      if (user != null) {
        return user.uid;
      } else {
        debugLog('Firebase에 로그인된 사용자가 없습니다.');
        return null;
      }
    } catch (e) {
      debugLog('Firebase에서 userUid를 가져오는 중 오류 발생: $e');
      return null;
    }
  }

  // 이벤트에 해당하는 장소 카드 목록 가져오기
  Future<List<LocationCardModel>> fetchEventLocations(int eventId) async {
    try {
      final headers = await _getAuthHeader();
      final response = await _dio.get(
        '/location/viewLocationByEvent',
        queryParameters: {'eventId': eventId},
        options: Options(headers: headers),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('장소 목록 응답 데이터: ${response.data}');

      if (response.statusCode == 200 && response.data is List) {
        // 모델의 fromMap 메서드를 사용하여 변환
        return (response.data as List)
            .map((item) => LocationCardModel.fromMap(item))
            .toList();
      } else {
        debugLog('잘못된 데이터 형식: ${response.data.runtimeType}');
        return [];
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      return [];
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return [];
    }
  }

  // 장소 상세 정보 가져오기
  Future<LocationDetail?> fetchLocationDetail(int locationId) async {
    try {
      // JWT 토큰 불러오기
      final token = await SecureStorage.getJwt();
      if (token == null) {
        debugLog('JWT 토큰이 없습니다.');
        return null;
      }

      // API 호출
      final response = await _dio.get(
        '/location/viewLocationByInfo',
        queryParameters: {'id': locationId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('장소 상세 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> locationData = response.data;
        return LocationDetail.fromJson(locationData);
      } else {
        debugLog('장소 상세 정보 가져오기 실패: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      debugLog('응답 내용: ${e.response?.data}');
      return null;
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return null;
    }
  }

  // 방문 여부 확인하는 API 호출
Future<Set<int>> fetchVisitedLocationSeqs(String userUid) async {
  try {
    final headers = await _getAuthHeader();
    final response = await _dio.get(
      '/letter/byUser',
      queryParameters: {'userUid': userUid},
      options: Options(headers: headers),
    );

    debugLog('방문 여부 응답 상태 코드: ${response.statusCode}');
    debugLog('방문 여부 응답 데이터: ${response.data}');

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => item['locationSeq'] as int)
          .toSet();
    } else {
      return {};
    }
  } on DioException catch (e) {
    debugLog('Dio 에러 발생: ${e.message}');
    return {};
  } catch (e) {
    debugLog('알 수 없는 에러: $e');
    return {};
  }
}
}

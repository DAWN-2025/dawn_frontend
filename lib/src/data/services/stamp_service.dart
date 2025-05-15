import 'package:dio/dio.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';
import '../models/stamp_card_model.dart';

class StampService {
  final Dio _dio;

  StampService() : _dio = DioClient().dio;

  // ✅ 토큰만 포함하는 헤더 가져오기
  Future<Map<String, String>> _getAuthHeaders() async {
    try {
      final token = await SecureStorage.getJwt();
      if (token != null) {
        return {'Authorization': 'Bearer $token'};
      } else {
        debugLog('토큰이 없습니다.');
        return {};
      }
    } catch (e) {
      debugLog('토큰 가져오는 중 오류 발생: $e');
      return {};
    }
  }

  // ✅ 사용자의 UID 가져오기
  String? _getUserUid() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // ✅ 사용자의 스탬프 목록 조회
  Future<List<Map<String, dynamic>>> fetchStampListByUser() async {
    try {
      final headers = await _getAuthHeaders();
      if (headers.isEmpty) return [];

      final userUid = _getUserUid();
      if (userUid == null || userUid.isEmpty) {
        debugLog('사용자 UID를 가져오지 못했습니다.');
        return [];
      }

      final response = await _dio.get(
        '/stamp/viewStampListByUser?userUid=$userUid',
        options: Options(headers: headers),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('스탬프 목록 조회 응답 데이터: ${response.data}');

      if (response.statusCode == 200 && response.data is List) {
        List<Map<String, dynamic>> stampList = 
            List<Map<String, dynamic>>.from(response.data);
        debugLog('스탬프 목록 조회 성공: ${stampList.length}개');
        return stampList;
      } else {
        debugLog('스탬프 목록 가져오기 실패');
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

  // ✅ 스탬프 카드 이미지 가져오기
  Future<List<StampCard>> fetchStampCards() async {
    try {
      final headers = await _getAuthHeaders();
      if (headers.isEmpty) return [];

      // 사용자 스탬프 목록 조회
      final userStampList = await fetchStampListByUser();

      // 스탬프 이미지 목록 조회
      final response = await _dio.get(
        '/stamp/getStampImage',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 && response.data is List) {
        List<StampCard> stampCards = (response.data as List).map((item) {
          final int eventSeq = item['eventSeq'] ?? 0;
          bool isVisited = false;

          for (var userStamp in userStampList) {
            final event = userStamp['event'];
            if (event != null && event['eventSeq'] == eventSeq) {
              final stamps = userStamp['stamps'];
              if (stamps is List && stamps.isNotEmpty) {
                isVisited = true;
                break;
              }
            }
          }

          return StampCard.fromJson(item, isVisited: isVisited);
        }).toList();

        debugLog('스탬프 카드 조회 성공: ${stampCards.length}개');
        return stampCards;
      } else {
        debugLog('스탬프 카드 목록 가져오기 실패');
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

  // ✅ 장소 방문 시 스탬프 만들기
  Future<bool> createStamp(int locationSeq, int eventSeq) async {
    try {
      final headers = await _getAuthHeaders();
      if (headers.isEmpty) {
        debugLog('헤더를 가져오지 못했습니다.');
        return false;
      }

      final userUid = _getUserUid();
      if (userUid == null || userUid.isEmpty) {
        debugLog('사용자 UID를 가져오지 못했습니다.');
        return false;
      }

      final requestBody = {
        'locationSeq': locationSeq,
        'eventSeq': eventSeq,
        'userUid': userUid,
      };

      final response = await _dio.post(
        '/stamp/createStamp',
        data: requestBody,
        options: Options(headers: headers),
      );

      debugLog('응답 상태 코드: ${response.statusCode}');
      debugLog('스탬프 생성 응답 데이터: ${response.data}');

      if (response.statusCode == 200) {
        debugLog('스탬프 생성 성공');
        return true;
      } else {
        debugLog('스탬프 생성 실패: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      return false;
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return false;
    }
  }
}

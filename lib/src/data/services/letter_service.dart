import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import '../../core/utils/log.dart';
import '../clients/dio_client.dart';
import 'package:dawn_frontend/src/data/models/letter_model.dart';

class LetterService {
  final Dio _dio;

  LetterService() : _dio = DioClient().dio;

  // JWT 토큰을 가져와 헤더로 설정
  Future<Map<String, String>> _getAuthHeader() async {
    final token = await SecureStorage.getJwt();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }

  // Firebase에서 userUid 가져오기
  Future<String?> _getUserUid() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        debugLog('Firebase UID: ${user.uid}');
        return user.uid;
      } else {
        debugLog('Firebase에 로그인된 사용자가 없습니다.');
        return null;
      }
    } catch (e) {
      debugLog('Firebase UID 가져오기 오류: $e');
      return null;
    }
  }

  Future<List<Letter>> fetchLettersByLocation(
    int locationSeq,
  ) async {
    try {
      final headers = await _getAuthHeader();
      final userUid = await _getUserUid(); // Firebase에서 UID 가져오기
      if (userUid == null) {
        debugLog('유효한 Firebase UID가 없습니다.');
        return [];
      }

      final response = await _dio.get(
        '/letter/byLocation',
        queryParameters: {'locationSeq':locationSeq,'userUid': userUid},
        options: Options(headers: headers),
      );

      debugLog('방문 여부 응답 상태 코드: ${response.statusCode}');
      debugLog('방문 여부 응답 데이터: ${response.data}');

      // 응답 데이터가 문자열인지 확인하여 처리
      dynamic rawData;
      if (response.data is String) {
        debugLog('응답 데이터가 String 형태로 되어 있습니다.');
        rawData = jsonDecode(response.data);
      } else if (response.data is List) {
        debugLog('응답 데이터가 List 형태로 되어 있습니다.');
        rawData = response.data;
      } else {
        debugLog('알 수 없는 데이터 타입: ${response.data.runtimeType}');
        return [];
      }

      final letters = rawData
    .map<Letter?>((item) {
      try {
        return Letter.fromJson(item as Map<String, dynamic>);
      } catch (e) {
        debugLog('Letter 변환 오류: $e');
        return null;
      }
    })
    .whereType<Letter>() // null을 제외한 Letter 타입만 필터링
    .toList();
      for (var letter in letters) {
        debugLog('Letter: ${letter.content}, Time: ${letter.letterTime}');
      }

      return letters;
    } on DioException catch (e) {
      debugLog('Dio 에러 발생: ${e.message}');
      return [];
    } catch (e) {
      debugLog('알 수 없는 에러: $e');
      return [];
    }
  }
}

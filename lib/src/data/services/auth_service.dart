import 'package:dawn_frontend/src/core/utils/log.dart';
import 'package:dawn_frontend/src/data/models/auth/create_user_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../clients/dio_client.dart';
import '../storage/secure_storage.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<String?> loginWithFirebaseToken(String idToken) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        options: Options(headers: {'Authorization': 'Bearer $idToken'}),
      );
      final jwt = response.data['token'];
      return jwt; // 앱이 이후 요청에 사용할 자체 JWT
    } on DioException catch (e) {
      debugLog('Login failed: ${e.response?.data ?? e.message}');
      return null;
    }
  }

  // JWT 토큰을 기반으로 유저 정보 요청
  Future<CreateUserRequestDto?> getUserInfoWithToken() async {
    String? jwt = await SecureStorage.getJwt();
    if (jwt == null) {
      debugLog("JWT 없음 → 자동 로그인 불가");
      return null;
    }

    try {
      // 1. JWT 유효성 검사
      final response = await _dio.get(
        '/auth/login/jwt',
        options: Options(headers: {'Authorization': 'Bearer $jwt'}),
      );
      debugLog('JWT is valid. UID: ${response.data['uid']}');
      final data = response.data as Map<String, dynamic>;
      return CreateUserRequestDto(uid: data['uid'], email: data['email']);
    } on DioException catch (e) {
      debugPrint("JWT 유효성 검사 실패: ${e.response?.data ?? e.message}");

      //2. JWT 만료 시 재발급
      // 2. Firebase 토큰 새로 발급
      final user = FirebaseAuth.instance.currentUser;
      final idToken = await user?.getIdToken(true); // 강제 재발급

      if (idToken == null) {
        debugLog("Firebase ID 토큰 재발급 실패");
        return null;
      }

      debugLog("Firebase ID 토큰 재발급 → 백엔드에 로그인 요청");
      final newJwt = await loginWithFirebaseToken(idToken);

      if (newJwt == null) {
        debugLog("JWT 재발급 실패");
        return null;
      }

      await SecureStorage.saveJwt(newJwt); // 새 JWT 저장
      debugLog("JWT 재발급 성공: $newJwt");
      return null;
    }
  }
}

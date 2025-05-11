import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _jwtKey = 'jwt_token';

  // 저장
  static Future<void> saveJwt(String token) async {
    await _storage.write(key: _jwtKey, value: token);
  }

  // 조회
  static Future<String?> getJwt() async {
    return await _storage.read(key: _jwtKey);
  }

  // 삭제
  static Future<void> deleteJwt() async {
    await _storage.delete(key: _jwtKey);
  }
}

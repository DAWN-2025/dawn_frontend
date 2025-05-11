import 'package:dawn_frontend/src/core/utils/log.dart';
import 'package:dio/dio.dart';
import '../clients/dio_client.dart';

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
}

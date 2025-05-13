import 'package:dawn_frontend/src/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/utils/log.dart';
import '../../../data/models/auth/create_user_request_dto.dart';
import '../../../data/storage/secure_storage.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthService _authService = AuthService();

  SignInViewModel(this._authRepository);

  String? _email;
  String? _password;

  String? get email => _email;

  String? get password => _password;

  void setEmail(String? email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String? password) {
    _password = password;
    notifyListeners();
  }

  bool isValid() {
    return email != null && password != null;
  }

  Future<String?> handleGoogleAuth() async {
    return await _authRepository.signInWithGoogle();
  }

  Future<String?> signIn() async {
    if (isValid()) {
      return await _authRepository.signInWithEmail(email!, password!);
    }
    return 'auth_try_again';
  }

  void resetFields() {
    _email = null;
    _password = null;
    notifyListeners();
  }

  /// JWT + Firebase 인증 기반 자동 로그인 시도
  Future<CreateUserRequestDto?> validateAndLogin() async {
    // 1. 저장된 JWT 검사
    final userInfo = await _authService.getUserInfoWithToken();

    if (userInfo != null) {
      debugLog('JWT 유효 → 로그인 유지됨');
      return userInfo;
    }

    debugLog('JWT 만료 → Firebase 토큰으로 재로그인 시도');

    // 2. Firebase 로그인 사용자 확인
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugLog('로그인된 Firebase 사용자가 없음');
      return null;
    }

    // 3. Firebase 토큰 재발급
    final idToken = await user.getIdToken(true);
    if (idToken == null) {
      debugLog('Firebase ID 토큰 재발급 실패');
      return null;
    }

    // 4. 백엔드에 로그인 → JWT 재발급
    final jwt = await _authRepository.loginWithFirebaseToken(idToken);
    if (jwt == null) {
      debugLog('JWT 재발급 실패');
      return null;
    }

    await SecureStorage.saveJwt(jwt);
    debugLog('JWT 재발급 및 저장 성공');

    // 5. 새 JWT로 다시 사용자 정보 요청
    final refreshedUser = await _authService.getUserInfoWithToken();
    if (refreshedUser == null) {
      debugLog('새 JWT로도 사용자 정보 조회 실패');
    }

    return refreshedUser;
  }
}

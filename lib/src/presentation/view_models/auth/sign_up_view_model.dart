import 'dart:async';

import 'package:dawn_frontend/src/core/utils/log.dart';
import 'package:dawn_frontend/src/data/storage/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/services/auth_service.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpViewModel(this._authRepository);

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  String? _email;
  String? _password;
  String? _confirmPassword;
  bool _agreeToTerms = false;
  bool _isPasswordValid = true;

  // Getters
  String? get email => _email;

  String? get password => _password;

  String? get confirmPassword => _confirmPassword;

  bool get agreeToTerms => _agreeToTerms;

  bool get isPasswordValid => _isPasswordValid;

  // Setters
  void setEmail(String? email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String? password) {
    _password = password;
    _isPasswordValid = password != null && password.length >= 6;
    notifyListeners();
  }

  void setConfirmPassword(String? confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void resetFields() {
    _email = null;
    _password = null;
    _confirmPassword = null;
    _agreeToTerms = false;
    _isPasswordValid = true;
    notifyListeners();
  }

  void setAgreeToTerms(bool agree) {
    _agreeToTerms = agree;
    notifyListeners();
  }

  bool isValid() {
    return email != null &&
        password != null &&
        confirmPassword != null &&
        email!.isNotEmpty &&
        password!.isNotEmpty &&
        confirmPassword!.isNotEmpty &&
        password == confirmPassword;
  }

  Future<String?> handleGoogleAuth() async {
    return await _authRepository.signInWithGoogle();
  }

  // 자체 회원 가입
  Future<String?> signUp() async {
    if (email == null || email!.isEmpty) return 'error_empty_email';
    if (password == null || password!.isEmpty) return 'error_empty_password';
    if (confirmPassword == null || confirmPassword!.isEmpty) {
      return 'error_empty_confirm';
    }
    if (!_isPasswordValid) return 'error_weak_password';
    if (password != confirmPassword) return 'error_password_mismatch';

    final result = await _authRepository.signUpWithEmail(_email!, _password!);
    return result; // null 이면 성공
  }

  Future<String?> signUpAndLoginToBackend() async {
    final result = await signUp();
    if (result != null) return result;

    final user = getCurrentUser();
    final idToken = await user?.getIdToken();

    if (idToken == null) return 'error_token_null';

    final jwt = await AuthService().loginWithFirebaseToken(idToken);
    if (jwt == null) return 'error_backend_auth';

    await SecureStorage.saveJwt(jwt);
    debugLog("토큰 발급 완료: $jwt");
    return null;
  }

  Future<String?> googleSignUpAndLoginToBackend() async {
    final result = await handleGoogleAuth();
    if (result != null) return result;

    final user = getCurrentUser();
    final idToken = await user?.getIdToken(true); // 새 토큰 발행 하도록 설정

    if (idToken == null) return 'error_token_null';

    final jwt = await AuthService().loginWithFirebaseToken(idToken);
    if (jwt == null) return 'error_backend_auth';

    await SecureStorage.saveJwt(jwt);
    debugLog("토큰 발급 완료: $jwt");
    return null;
  }
}

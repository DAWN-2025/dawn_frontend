import 'package:flutter/cupertino.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpViewModel(this._authRepository);

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

  // Business Logic
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

  Future<String?> signUp() async {
    if (email == null || email!.isEmpty) return 'error_empty_email';
    if (password == null || password!.isEmpty) return 'error_empty_password';
    if (confirmPassword == null || confirmPassword!.isEmpty) return 'error_empty_confirm';
    if (!_isPasswordValid) return 'error_weak_password';
    if (password != confirmPassword) return 'error_password_mismatch';

    final result = await _authRepository.signUpWithEmail(_email!, _password!);
    return result; // null 이면 성공
  }
}

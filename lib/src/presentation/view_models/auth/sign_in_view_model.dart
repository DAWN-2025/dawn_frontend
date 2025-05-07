import 'package:flutter/cupertino.dart';
import '../../../domain/repositories/auth_repository.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

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
}

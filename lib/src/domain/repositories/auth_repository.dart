import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 이메일 인증
      await userCredential.user?.sendEmailVerification();
      return null;
      //return 'email_verification_sent';
    } on FirebaseAuthException catch (e) {
      //throw Exception(_firebaseErrorKey(e));
      return _firebaseErrorKey(e);
    }
  }

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return 'auth_try_again';
    }
  }

  String _firebaseErrorKey(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'error_email_already_in_use';
      case 'invalid-email':
        return 'error_invalid_email';
      case 'weak-password':
        return 'error_weak_password';
      default:
        return 'error_signup_failed';
    }
  }
}

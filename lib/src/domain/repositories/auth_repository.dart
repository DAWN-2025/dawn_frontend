import 'dart:async';

import 'package:dawn_frontend/src/core/utils/log.dart';
import 'package:dawn_frontend/src/data/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/clients/dio_client.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Dio _dio = DioClient().dio;
  final AuthService _authService = AuthService();

  // 구글 로그인 및 회원 가입
  Future<String?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'auth_cancelled'; // 취소

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      ); // userCredential.additionalUserInfo?.isNewUser 확인 가능
      return null; // 성공
    } on FirebaseAuthException catch (e) {
      return _firebaseErrorKey(e);
    } catch (_) {
      return 'auth_google_failed';
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      // Handle sign out error
    }
  }

  // 이메일로 회원 가입
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 이메일 인증
      //await userCredential.user?.sendEmailVerification();
      return null;
      //return 'email_verification_sent';
    } on FirebaseAuthException catch (e) {
      //throw Exception(_firebaseErrorKey(e));
      return _firebaseErrorKey(e);
    }
  }

  // 이메일 로그인
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _firebaseErrorKey(e);
    }

    // await _googleSignIn.disconnect(); // 구글 계정 연결 해제
    // await _firebaseAuth.signOut();    // Firebase 인증 로그아웃
  }

  String _firebaseErrorKey(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'error_email_already_in_use';
      case 'invalid-email':
        return 'error_invalid_email';
      case 'user-not-found':
        return 'error_user_not_found';
      case 'wrong-password':
        return 'error_wrong_password';
      case 'weak-password':
        return 'error_weak_password';
      default:
        return 'error_signup_failed';
    }
  }

  // JWT 로그인
  Future<String?> loginWithFirebaseToken(String idToken) {
    return _authService.loginWithFirebaseToken(idToken);
  }
}

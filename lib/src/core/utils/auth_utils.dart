import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Firebase 및 Google 인증 세션 초기화 (로그아웃)
Future<void> forceLogout() async {
  try {
    await GoogleSignIn().signOut();
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print('Logout failed: $e');
  }
}

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _keyLanguage = 'selected_language'; // 언어 설정 키
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  Future<void> setLanguage(String language) async {
    await _prefs.setString(_keyLanguage, language);
    if (kDebugMode) {
      debugPrint('Selected language: $language');
    }
  }

  String getLanguage() {
    return _prefs.getString(_keyLanguage) ?? 'en'; // 키가 없을 때 'en' 반환
  }
}

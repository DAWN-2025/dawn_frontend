import 'package:dawn_frontend/src/data/local/app_preferences.dart';
import 'package:flutter/cupertino.dart';

class LanguageViewModel extends ChangeNotifier {
  final AppPreferences _prefs;
  final String _display;

  String get display => _display;

  static const _mapToCode = {'한국어': 'ko', 'English': 'en'};

  // 설정 화면에서도 사용
  static const _mapToDisplay = {'ko': '한국어', 'en': 'English'};

  LanguageViewModel(this._prefs)
    : _display = _mapToDisplay[_prefs.getLanguage()] ?? 'English';

  Future<void> changeLanguage(String selectedLang) async {
    await _prefs.setLanguage(_mapToCode[selectedLang] ?? 'en');
    notifyListeners();
  }
}

import 'package:dawn_frontend/src/data/local/app_preferences.dart';
import 'package:flutter/cupertino.dart';

class LanguageViewModel extends ChangeNotifier {
  final AppPreferences _prefs;

  static const _mapToCode = {'한국어': 'ko', 'English': 'en'};

  // 설정 화면에서도 사용
  static const _mapToDisplay = {'ko': '한국어', 'en': 'English'};

  late String _display; //화면에 나타낼 문자열
  late Locale _currentLocale;

  // getters
  String get display => _display;

  Locale get currentLocale => _currentLocale;

  LanguageViewModel(this._prefs) {
    // 초기화 시점에 언어 설정을 가져옴
    _currentLocale = Locale(_prefs.getLanguage());
    _display = _mapToDisplay[_prefs.getLanguage()] ?? 'English';
  }

  Future<void> changeLanguage(String selectedLang) async {
    await _prefs.setLanguage(_mapToCode[selectedLang] ?? 'en');

    _display = selectedLang;
    _currentLocale = Locale(_mapToCode[selectedLang] ?? 'en');

    notifyListeners();
  }
}

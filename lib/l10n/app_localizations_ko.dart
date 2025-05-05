// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get example => '안녕하세요!';

  @override
  String get sign_in => '로그인';

  @override
  String get sign_up => '회원가입';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get check_password => '비밀번호 확인';

  @override
  String get login_btn => '로그인 하기';

  @override
  String get or => '또는';

  @override
  String get sign_up_description => '아직 계정이 없으신가요?';

  @override
  String get sign_up_btn => '회원가입';

  @override
  String get sign_in_description => '계정이 있으신가요?';

  @override
  String get sign_in_btn => '로그인 하기';
}

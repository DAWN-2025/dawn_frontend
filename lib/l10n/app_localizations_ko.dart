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
  String get sign_in_btn => '로그인';

  @override
  String get error_empty_email => '이메일을 입력해 주세요.';

  @override
  String get error_empty_password => '비밀번호를 입력해 주세요.';

  @override
  String get error_empty_confirm_password => '비밀번호 확인을 입력해 주세요.';

  @override
  String get error_weak_password => '비밀번호는 최소 6자 이상이어야 합니다.';

  @override
  String get error_password_mismatch => '비밀번호가 일치하지 않습니다.';

  @override
  String get error_invalid_input => '입력값이 올바르지 않습니다. 다시 시도해 주세요.';

  @override
  String get error_email_already_in_use => '이미 사용 중인 이메일입니다.';

  @override
  String get error_invalid_email => '유효하지 않은 이메일 형식입니다.';

  @override
  String get error_signup_failed => '회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get email_verification_sent => '이메일 확인 링크가 발송되었습니다. 이메일을 확인해 주세요.';
}

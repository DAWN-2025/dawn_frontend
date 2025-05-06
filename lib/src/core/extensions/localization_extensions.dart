import 'package:dawn_frontend/l10n/app_localizations.dart';

extension LocalizationKeyResolver on AppLocalizations {
  String getByKey(String key) {
    switch (key) {
      case 'error_empty_email':
        return error_empty_email;
      case 'error_empty_password':
        return error_empty_password;
      case 'error_empty_confirm_password':
        return error_empty_confirm_password;
      case 'error_password_mismatch':
        return error_password_mismatch;
      case 'error_invalid_email':
        return error_invalid_email;
      case 'error_weak_password':
        return error_weak_password;
      case 'error_email_already_in_use':
        return error_email_already_in_use;
      case 'error_signup_failed':
        return error_signup_failed;
      case 'email_verification_sent':
        return email_verification_sent;
      default:
        return key; // 기본적으로 키를 반환
    }
  }
}

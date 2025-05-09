// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get example => 'Hello!';

  @override
  String get sign_in => 'Sign In';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get check_password => 'Confirm password';

  @override
  String get login_btn => 'Continue';

  @override
  String get or => 'OR';

  @override
  String get sign_up_description => 'Don\'t have an account?';

  @override
  String get sign_up_btn => 'Sign Up';

  @override
  String get sign_in_description => 'Already have an account?';

  @override
  String get sign_in_btn => 'Sign In';

  @override
  String get error_empty_email => 'Email cannot be empty.';

  @override
  String get error_empty_password => 'Password cannot be empty.';

  @override
  String get error_empty_confirm_password => 'Please confirm your password.';

  @override
  String get error_weak_password => 'Password must be at least 6 characters.';

  @override
  String get error_password_mismatch => 'Passwords do not match.';

  @override
  String get error_invalid_input => 'Invalid input. Please try again.';

  @override
  String get error_email_already_in_use => 'This email is already in use.';

  @override
  String get error_invalid_email => 'Please enter a valid email address.';

  @override
  String get error_signup_failed => 'Sign-up failed. Please try again.';

  @override
  String get email_verification_sent => 'A verification link has been sent to your email. Please check your inbox.';

  @override
  String get auth_try_again => 'Please try again.';

  @override
  String get search_hint => 'Search';

  @override
  String get week_1 => 'First week';

  @override
  String get week_2 => 'Second week';

  @override
  String get week_3 => 'Third week';

  @override
  String get week_4 => 'Fourth week';

  @override
  String get week_5 => 'Fifth week';

  @override
  String get event => 'Events';
}

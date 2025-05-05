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
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login_btn => 'Continue';

  @override
  String get or => 'OR';

  @override
  String get sign_up_description => 'Don\'t have an account?';

  @override
  String get sign_up_btn => 'Sign Up';
}

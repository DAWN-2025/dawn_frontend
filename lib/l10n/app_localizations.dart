import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get example;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @check_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get check_password;

  /// No description provided for @login_btn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get login_btn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @sign_up_description.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get sign_up_description;

  /// No description provided for @sign_up_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up_btn;

  /// No description provided for @sign_in_description.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get sign_in_description;

  /// No description provided for @sign_in_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in_btn;

  /// No description provided for @error_empty_email.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty.'**
  String get error_empty_email;

  /// No description provided for @error_empty_password.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty.'**
  String get error_empty_password;

  /// No description provided for @error_empty_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get error_empty_confirm_password;

  /// No description provided for @error_weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get error_weak_password;

  /// No description provided for @error_password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get error_password_mismatch;

  /// No description provided for @error_invalid_input.
  ///
  /// In en, this message translates to:
  /// **'Invalid input. Please try again.'**
  String get error_invalid_input;

  /// No description provided for @error_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use.'**
  String get error_email_already_in_use;

  /// No description provided for @error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get error_invalid_email;

  /// No description provided for @error_signup_failed.
  ///
  /// In en, this message translates to:
  /// **'Sign-up failed. Please try again.'**
  String get error_signup_failed;

  /// No description provided for @email_verification_sent.
  ///
  /// In en, this message translates to:
  /// **'A verification link has been sent to your email. Please check your inbox.'**
  String get email_verification_sent;

  /// No description provided for @auth_try_again.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get auth_try_again;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_hint;

  /// No description provided for @week_1.
  ///
  /// In en, this message translates to:
  /// **'First week'**
  String get week_1;

  /// No description provided for @week_2.
  ///
  /// In en, this message translates to:
  /// **'Second week'**
  String get week_2;

  /// No description provided for @week_3.
  ///
  /// In en, this message translates to:
  /// **'Third week'**
  String get week_3;

  /// No description provided for @week_4.
  ///
  /// In en, this message translates to:
  /// **'Fourth week'**
  String get week_4;

  /// No description provided for @week_5.
  ///
  /// In en, this message translates to:
  /// **'Fifth week'**
  String get week_5;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get event;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResults;

  /// No description provided for @instead_events.
  ///
  /// In en, this message translates to:
  /// **'See this week\'s featured events instead'**
  String get instead_events;

  /// No description provided for @map_notice.
  ///
  /// In en, this message translates to:
  /// **'There are 2 locations marked on the map. Tap to view more details.'**
  String get map_notice;

  /// No description provided for @emailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email address copied to clipboard!'**
  String get emailCopied;

  /// No description provided for @settingsIntroMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using our app!\nWe are currently working hard to design and develop the service\nto create a better dark tourism culture.\n\nIf you have any recommendations, ideas, or improvements\nplease feel free to contact us.\nYour feedback is very helpful!'**
  String get settingsIntroMessage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ko': return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

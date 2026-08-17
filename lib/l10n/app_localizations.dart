import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your trip with peace of mind'**
  String get onboardingTitle;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Organize your budget before you even pack your bags and keep track of every expense in one place.'**
  String get onboardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get getStarted;

  /// No description provided for @travler_form_title.
  ///
  /// In en, this message translates to:
  /// **'Planner'**
  String get travler_form_title;

  /// No description provided for @travler_form_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Organize your upcoming trips'**
  String get travler_form_subtitle;

  /// No description provided for @travler_form_create_before.
  ///
  /// In en, this message translates to:
  /// **'Start without creating a trip'**
  String get travler_form_create_before;

  /// No description provided for @travler_form_name.
  ///
  /// In en, this message translates to:
  /// **'Trip name'**
  String get travler_form_name;

  /// No description provided for @travler_form_budget.
  ///
  /// In en, this message translates to:
  /// **'Budget (R\$)'**
  String get travler_form_budget;

  /// No description provided for @travler_form_roundtrip.
  ///
  /// In en, this message translates to:
  /// **'Roundtrip'**
  String get travler_form_roundtrip;

  /// No description provided for @travler_form_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get travler_form_save;

  /// No description provided for @home_empty_list_title.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get home_empty_list_title;

  /// No description provided for @home_create_new_travel.
  ///
  /// In en, this message translates to:
  /// **'Create your first trip'**
  String get home_create_new_travel;

  /// No description provided for @home_app_title.
  ///
  /// In en, this message translates to:
  /// **'Travel Wallet'**
  String get home_app_title;

  /// No description provided for @auth_sign_in_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get auth_sign_in_title;

  /// No description provided for @auth_sign_in_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep planning your trips'**
  String get auth_sign_in_subtitle;

  /// No description provided for @auth_sign_up_title.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get auth_sign_up_title;

  /// No description provided for @auth_sign_up_subtitle.
  ///
  /// In en, this message translates to:
  /// **'It only takes a minute to get started'**
  String get auth_sign_up_subtitle;

  /// No description provided for @auth_recovery_title.
  ///
  /// In en, this message translates to:
  /// **'Recover password'**
  String get auth_recovery_title;

  /// No description provided for @auth_recovery_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password for your account'**
  String get auth_recovery_subtitle;

  /// No description provided for @auth_field_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get auth_field_name;

  /// No description provided for @auth_field_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_field_email;

  /// No description provided for @auth_field_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_field_password;

  /// No description provided for @auth_field_new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get auth_field_new_password;

  /// No description provided for @auth_field_password_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get auth_field_password_confirmation;

  /// No description provided for @auth_sign_in_action.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get auth_sign_in_action;

  /// No description provided for @auth_sign_up_action.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get auth_sign_up_action;

  /// No description provided for @auth_recovery_verify_action.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get auth_recovery_verify_action;

  /// No description provided for @auth_recovery_reset_action.
  ///
  /// In en, this message translates to:
  /// **'Save new password'**
  String get auth_recovery_reset_action;

  /// No description provided for @auth_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get auth_forgot_password;

  /// No description provided for @auth_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get auth_no_account;

  /// No description provided for @auth_has_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get auth_has_account;

  /// No description provided for @auth_google_action.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get auth_google_action;

  /// No description provided for @auth_divider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get auth_divider;

  /// No description provided for @auth_recovery_success.
  ///
  /// In en, this message translates to:
  /// **'Password updated. Sign in with your new password.'**
  String get auth_recovery_success;

  /// No description provided for @auth_back_to_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get auth_back_to_sign_in;

  /// No description provided for @auth_recovery_subtitle_password.
  ///
  /// In en, this message translates to:
  /// **'Choose a new password for your account'**
  String get auth_recovery_subtitle_password;

  /// No description provided for @auth_recovery_account.
  ///
  /// In en, this message translates to:
  /// **'Recovering the account {email}'**
  String auth_recovery_account(String email);

  /// No description provided for @auth_continue_without_account.
  ///
  /// In en, this message translates to:
  /// **'Continue without an account'**
  String get auth_continue_without_account;

  /// No description provided for @nav_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get nav_trips;

  /// No description provided for @nav_new_trip.
  ///
  /// In en, this message translates to:
  /// **'New trip'**
  String get nav_new_trip;

  /// No description provided for @nav_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get nav_account;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

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

  /// No description provided for @details_title.
  ///
  /// In en, this message translates to:
  /// **'Trip details'**
  String get details_title;

  /// No description provided for @details_spent_of.
  ///
  /// In en, this message translates to:
  /// **'{spent} of {budget}'**
  String details_spent_of(String spent, String budget);

  /// No description provided for @details_remaining.
  ///
  /// In en, this message translates to:
  /// **'{value} left'**
  String details_remaining(String value);

  /// No description provided for @details_over_budget.
  ///
  /// In en, this message translates to:
  /// **'{value} over budget'**
  String details_over_budget(String value);

  /// No description provided for @details_no_budget.
  ///
  /// In en, this message translates to:
  /// **'No budget set for this trip'**
  String get details_no_budget;

  /// No description provided for @details_expenses_title.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get details_expenses_title;

  /// No description provided for @details_empty_expenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get details_empty_expenses;

  /// No description provided for @details_empty_category.
  ///
  /// In en, this message translates to:
  /// **'No expenses in this category'**
  String get details_empty_category;

  /// No description provided for @details_add_expense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get details_add_expense;

  /// No description provided for @details_expense_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get details_expense_description;

  /// No description provided for @details_expense_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get details_expense_amount;

  /// No description provided for @details_expense_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get details_expense_category;

  /// No description provided for @details_expense_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get details_expense_date;

  /// No description provided for @details_expense_save.
  ///
  /// In en, this message translates to:
  /// **'Save expense'**
  String get details_expense_save;

  /// No description provided for @details_expense_removed.
  ///
  /// In en, this message translates to:
  /// **'Expense removed'**
  String get details_expense_removed;

  /// No description provided for @filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filter_all;

  /// No description provided for @category_lodging.
  ///
  /// In en, this message translates to:
  /// **'Lodging'**
  String get category_lodging;

  /// No description provided for @category_transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get category_transport;

  /// No description provided for @category_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get category_food;

  /// No description provided for @category_leisure.
  ///
  /// In en, this message translates to:
  /// **'Leisure'**
  String get category_leisure;

  /// No description provided for @category_shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get category_shopping;

  /// No description provided for @category_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_other;

  /// No description provided for @travler_form_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get travler_form_edit_title;

  /// No description provided for @details_edit_travel.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get details_edit_travel;

  /// No description provided for @details_delete_travel.
  ///
  /// In en, this message translates to:
  /// **'Delete trip'**
  String get details_delete_travel;

  /// No description provided for @details_delete_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Delete this trip?'**
  String get details_delete_confirm_title;

  /// No description provided for @details_delete_confirm_message.
  ///
  /// In en, this message translates to:
  /// **'The trip and all of its expenses will be removed. This cannot be undone.'**
  String get details_delete_confirm_message;

  /// No description provided for @details_delete_confirm_action.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get details_delete_confirm_action;

  /// No description provided for @details_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get details_cancel;

  /// No description provided for @details_finished_travel.
  ///
  /// In en, this message translates to:
  /// **'This trip has ended, so no new expenses can be added.'**
  String get details_finished_travel;
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

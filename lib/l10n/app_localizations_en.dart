// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle => 'Plan your trip with peace of mind';

  @override
  String get onboardingDescription =>
      'Organize your budget before you even pack your bags and keep track of every expense in one place.';

  @override
  String get getStarted => 'Start now';

  @override
  String get travler_form_title => 'Planner';

  @override
  String get travler_form_subtitle => 'Organize your upcoming trips';

  @override
  String get travler_form_create_before => 'Start without creating a trip';

  @override
  String get travler_form_name => 'Trip name';

  @override
  String get travler_form_budget => 'Budget (R\$)';

  @override
  String get travler_form_roundtrip => 'Roundtrip';

  @override
  String get travler_form_save => 'Save';

  @override
  String get home_empty_list_title => 'No trips yet';

  @override
  String get home_create_new_travel => 'Create your first trip';

  @override
  String get home_app_title => 'Travel Wallet';

  @override
  String get auth_sign_in_title => 'Welcome back';

  @override
  String get auth_sign_in_subtitle => 'Sign in to keep planning your trips';

  @override
  String get auth_sign_up_title => 'Create your account';

  @override
  String get auth_sign_up_subtitle => 'It only takes a minute to get started';

  @override
  String get auth_recovery_title => 'Recover password';

  @override
  String get auth_recovery_subtitle => 'Set a new password for your account';

  @override
  String get auth_field_name => 'Full name';

  @override
  String get auth_field_email => 'Email';

  @override
  String get auth_field_password => 'Password';

  @override
  String get auth_field_new_password => 'New password';

  @override
  String get auth_field_password_confirmation => 'Confirm password';

  @override
  String get auth_sign_in_action => 'Sign in';

  @override
  String get auth_sign_up_action => 'Create account';

  @override
  String get auth_recovery_verify_action => 'Continue';

  @override
  String get auth_recovery_reset_action => 'Save new password';

  @override
  String get auth_forgot_password => 'Forgot your password?';

  @override
  String get auth_no_account => 'Don\'t have an account? Sign up';

  @override
  String get auth_has_account => 'Already have an account? Sign in';

  @override
  String get auth_google_action => 'Continue with Google';

  @override
  String get auth_divider => 'or';

  @override
  String get auth_recovery_success =>
      'Password updated. Sign in with your new password.';

  @override
  String get auth_back_to_sign_in => 'Back to sign in';

  @override
  String get auth_recovery_subtitle_password =>
      'Choose a new password for your account';

  @override
  String auth_recovery_account(String email) {
    return 'Recovering the account $email';
  }

  @override
  String get auth_continue_without_account => 'Continue without an account';

  @override
  String get nav_trips => 'Trips';

  @override
  String get nav_new_trip => 'New trip';

  @override
  String get nav_account => 'Account';
}

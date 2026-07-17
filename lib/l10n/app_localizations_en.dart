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
}

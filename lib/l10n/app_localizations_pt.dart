// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get onboardingTitle => 'Planeje sua viagem com tranquilidade';

  @override
  String get onboardingDescription =>
      'Organize seu orçamento antes mesmo de fazer as malas e acompanhe todos os seus gastos em um só lugar.';

  @override
  String get getStarted => 'Começar agora';

  @override
  String get travler_form_title => 'Planeje';

  @override
  String get travler_form_subtitle => 'Organize suas próximas viagens';

  @override
  String get travler_form_create_before => 'Começar sem criar viagem';

  @override
  String get travler_form_name => 'Nome da viagem';

  @override
  String get travler_form_budget => 'Orçamento (R\$)';

  @override
  String get travler_form_roundtrip => 'Ida e volta';

  @override
  String get travler_form_save => 'Salvar';
}

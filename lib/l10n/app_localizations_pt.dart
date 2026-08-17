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

  @override
  String get home_empty_list_title => 'Ainda não há viagens';

  @override
  String get home_create_new_travel => 'Crie sua primeira viagem';

  @override
  String get home_app_title => 'Carteira de Viagem';

  @override
  String get auth_sign_in_title => 'Bem-vindo de volta';

  @override
  String get auth_sign_in_subtitle => 'Entre para continuar planejando suas viagens';

  @override
  String get auth_sign_up_title => 'Crie sua conta';

  @override
  String get auth_sign_up_subtitle => 'Leva menos de um minuto para começar';

  @override
  String get auth_recovery_title => 'Recuperar senha';

  @override
  String get auth_recovery_subtitle => 'Defina uma nova senha para sua conta';

  @override
  String get auth_field_name => 'Nome completo';

  @override
  String get auth_field_email => 'E-mail';

  @override
  String get auth_field_password => 'Senha';

  @override
  String get auth_field_new_password => 'Nova senha';

  @override
  String get auth_field_password_confirmation => 'Confirmar senha';

  @override
  String get auth_sign_in_action => 'Entrar';

  @override
  String get auth_sign_up_action => 'Criar conta';

  @override
  String get auth_recovery_verify_action => 'Continuar';

  @override
  String get auth_recovery_reset_action => 'Salvar nova senha';

  @override
  String get auth_forgot_password => 'Esqueceu sua senha?';

  @override
  String get auth_no_account => 'Não tem uma conta? Cadastre-se';

  @override
  String get auth_has_account => 'Já tem uma conta? Entrar';

  @override
  String get auth_google_action => 'Continuar com o Google';

  @override
  String get auth_divider => 'ou';

  @override
  String get auth_recovery_success => 'Senha atualizada. Entre com sua nova senha.';

  @override
  String get auth_back_to_sign_in => 'Voltar para o login';

  @override
  String get auth_recovery_subtitle_password => 'Escolha uma nova senha para sua conta';

  @override
  String auth_recovery_account(String email) {
    return 'Recuperando a conta $email';
  }

  @override
  String get auth_continue_without_account => 'Continuar sem conta';

  @override
  String get nav_trips => 'Viagens';

  @override
  String get nav_new_trip => 'Nova viagem';

  @override
  String get nav_account => 'Conta';

  @override
  String get details_title => 'Detalhes da viagem';

  @override
  String details_spent_of(String spent, String budget) {
    return '$spent de $budget';
  }

  @override
  String details_remaining(String value) {
    return 'Restam $value';
  }

  @override
  String details_over_budget(String value) {
    return '$value acima do orçamento';
  }

  @override
  String get details_no_budget => 'Sem orçamento definido para esta viagem';

  @override
  String get details_expenses_title => 'Lançamentos';

  @override
  String get details_empty_expenses => 'Nenhum lançamento ainda';

  @override
  String get details_empty_category => 'Nenhum lançamento nesta categoria';

  @override
  String get details_add_expense => 'Novo lançamento';

  @override
  String get details_expense_description => 'Descrição';

  @override
  String get details_expense_amount => 'Valor';

  @override
  String get details_expense_category => 'Categoria';

  @override
  String get details_expense_date => 'Data';

  @override
  String get details_expense_save => 'Salvar lançamento';

  @override
  String get details_expense_removed => 'Lançamento removido';

  @override
  String get filter_all => 'Todos';

  @override
  String get category_lodging => 'Hospedagem';

  @override
  String get category_transport => 'Transporte';

  @override
  String get category_food => 'Alimentação';

  @override
  String get category_leisure => 'Lazer';

  @override
  String get category_shopping => 'Compras';

  @override
  String get category_other => 'Outros';

  @override
  String get travler_form_edit_title => 'Editar viagem';

  @override
  String get details_edit_travel => 'Editar viagem';

  @override
  String get details_delete_travel => 'Excluir viagem';

  @override
  String get details_delete_confirm_title => 'Excluir esta viagem?';

  @override
  String get details_delete_confirm_message =>
      'A viagem e todos os seus lançamentos serão removidos. Não dá para desfazer.';

  @override
  String get details_delete_confirm_action => 'Excluir';

  @override
  String get details_cancel => 'Cancelar';

  @override
  String get details_finished_travel =>
      'Esta viagem já terminou, não é possível adicionar lançamentos.';
}

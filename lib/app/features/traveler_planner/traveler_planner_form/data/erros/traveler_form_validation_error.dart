import 'i_traveler_planner_form_erros.dart';

class TravelerFormValidationError extends ITravelerPlannerFormErros {
  @override
  final String message;

  TravelerFormValidationError({required this.message});
}

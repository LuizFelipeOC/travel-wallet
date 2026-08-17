import 'i_traveler_planner_form_erros.dart';

class TravelerFormSubmissionError extends ITravelerPlannerFormErros {
  @override
  final String message;

  TravelerFormSubmissionError({required this.message});
}

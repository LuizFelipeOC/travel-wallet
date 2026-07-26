abstract class ITravelerPlannerFormErros implements Exception {
  String get message;
}

class TravelerFormValidationError extends ITravelerPlannerFormErros {
  @override
  final String message;

  TravelerFormValidationError({required this.message});
}

class TravelerFormSubmissionError extends ITravelerPlannerFormErros {
  @override
  final String message;

  TravelerFormSubmissionError({required this.message});
}

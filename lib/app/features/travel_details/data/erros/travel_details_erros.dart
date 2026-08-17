abstract class ITravelDetailsErros implements Exception {
  String get message;
}

class ExpenseValidationError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseValidationError({required this.message});
}

class ExpenseLoadError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseLoadError({required this.message});
}

class ExpenseSubmissionError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseSubmissionError({required this.message});
}

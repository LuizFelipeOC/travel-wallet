import 'i_travel_details_erros.dart';

class ExpenseSubmissionError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseSubmissionError({required this.message});
}

import 'i_travel_details_erros.dart';

class ExpenseValidationError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseValidationError({required this.message});
}

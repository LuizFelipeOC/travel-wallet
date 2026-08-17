import 'i_travel_details_erros.dart';

class ExpenseLoadError extends ITravelDetailsErros {
  @override
  final String message;

  ExpenseLoadError({required this.message});
}

import '../data/models/expense.dart';

class NewExpenseResult {
  final String description;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  NewExpenseResult({
    required this.description,
    required this.amount,
    required this.category,
    required this.date,
  });
}

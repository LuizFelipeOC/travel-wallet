import '../../data/models/expense.dart';
import 'i_travel_details_state.dart';

class TravelDetailsLoaded implements ITravelDetailsState {
  final List<ExpenseModel> expenses;

  /// `null` means the "all" filter is active.
  final ExpenseCategory? selectedCategory;

  final double budget;

  TravelDetailsLoaded({required this.expenses, required this.budget, this.selectedCategory});

  List<ExpenseModel> get filteredExpenses {
    if (selectedCategory == null) {
      return expenses;
    }

    return expenses.where((expense) => expense.category == selectedCategory).toList();
  }

  double get totalSpent => expenses.fold(0, (total, expense) => total + expense.amount);

  double get remaining => budget - totalSpent;

  bool get isOverBudget => totalSpent > budget;

  /// Progress of the budget already spent, clamped so the bar never overflows.
  double get progress {
    if (budget <= 0) {
      return totalSpent > 0 ? 1 : 0;
    }

    return (totalSpent / budget).clamp(0.0, 1.0);
  }

  /// Totals per category, ordered by the amount spent.
  Map<ExpenseCategory, double> get totalsByCategory {
    final totals = <ExpenseCategory, double>{};

    for (final expense in expenses) {
      totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
    }

    final entries = totals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(entries);
  }

  /// Categories that actually have expenses, for the filter chips.
  List<ExpenseCategory> get usedCategories => totalsByCategory.keys.toList();

  TravelDetailsLoaded copyWith({
    List<ExpenseModel>? expenses,
    ExpenseCategory? selectedCategory,
    bool clearCategory = false,
  }) {
    return TravelDetailsLoaded(
      expenses: expenses ?? this.expenses,
      budget: budget,
      selectedCategory: clearCategory ? null : selectedCategory ?? this.selectedCategory,
    );
  }
}

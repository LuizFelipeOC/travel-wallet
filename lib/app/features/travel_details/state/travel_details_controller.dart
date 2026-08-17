import 'package:flutter/material.dart';

import '../../../core/result/result.dart';
import '../../traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import '../data/erros/travel_details_erros.dart';
import '../data/models/expense.dart';
import '../data/repositories/expense_repository.dart';
import 'travel_details_state.dart';

class TravelDetailsController extends ValueNotifier<ITravelDetailsState> {
  final ExpenseRepository expenseRepository;

  CreateFormRequestModel? _travel;

  String get _travelId => _travel?.id ?? '';
  double get _budget => double.tryParse(_travel?.budgetPlan.replaceAll(',', '.').trim() ?? '') ?? 0;

  /// Closed travels are read only.
  bool get isTravelFinished => _travel?.isFinished ?? false;

  TravelDetailsController({required this.expenseRepository}) : super(TravelDetailsInitial());

  Future<void> loadExpenses({required CreateFormRequestModel travel}) async {
    _travel = travel;

    final previous = value;
    final selectedCategory = previous is TravelDetailsLoaded ? previous.selectedCategory : null;

    setState(state: TravelDetailsLoading());

    final result = await expenseRepository.getExpenses(travelId: travel.id);

    switch (result) {
      case Success(data: final expenses):
        setState(
          state: TravelDetailsLoaded(
            expenses: expenses,
            budget: _budget,
            // A filter with no expenses left would show an empty list with no
            // way back, so it is dropped when the category disappears.
            selectedCategory: expenses.any((e) => e.category == selectedCategory)
                ? selectedCategory
                : null,
          ),
        );
        return;
      case Failure(error: final error):
        setState(state: TravelDetailsError(message: _messageOf(error)));
        return;
      default:
        setState(state: TravelDetailsError(message: 'Unexpected error'));
        return;
    }
  }

  void filterByCategory(ExpenseCategory? category) {
    final current = value;

    if (current is! TravelDetailsLoaded) {
      return;
    }

    setState(
      state: current.copyWith(selectedCategory: category, clearCategory: category == null),
    );
  }

  Future<bool> addExpense({
    required String description,
    required double amount,
    required ExpenseCategory category,
    required DateTime date,
  }) async {
    if (isTravelFinished) {
      setState(state: TravelDetailsError(message: 'This travel has already ended.'));
      return false;
    }

    final expense = ExpenseModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      travelId: _travelId,
      description: description.trim(),
      amount: amount,
      category: category,
      date: date,
    );

    final result = await expenseRepository.createExpense(expense: expense);

    switch (result) {
      case Success(data: _):
        await _reload();
        return true;
      case Failure(error: final error):
        setState(state: TravelDetailsError(message: _messageOf(error)));
        return false;
      default:
        setState(state: TravelDetailsError(message: 'Unexpected error'));
        return false;
    }
  }

  Future<void> removeExpense({required String id}) async {
    final result = await expenseRepository.deleteExpense(id: id);

    switch (result) {
      case Success(data: _):
        await _reload();
        return;
      case Failure(error: final error):
        setState(state: TravelDetailsError(message: _messageOf(error)));
        return;
      default:
        setState(state: TravelDetailsError(message: 'Unexpected error'));
        return;
    }
  }

  Future<void> _reload() async {
    final travel = _travel;

    if (travel != null) {
      await loadExpenses(travel: travel);
    }
  }

  String _messageOf(Object error) {
    if (error is ITravelDetailsErros) {
      return error.message;
    }

    return 'Unexpected error';
  }

  void setState({required ITravelDetailsState state}) {
    value = state;
  }
}

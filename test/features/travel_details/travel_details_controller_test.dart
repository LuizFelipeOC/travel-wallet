import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/travel_details/data/models/expense.dart';
import 'package:travel_wallet/app/features/travel_details/data/repositories/expense_repository.dart';
import 'package:travel_wallet/app/features/travel_details/state/travel_details_controller.dart';
import 'package:travel_wallet/app/features/travel_details/state/travel_details_state.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class FakeExpenseModel extends Fake implements ExpenseModel {}

void main() {
  late MockExpenseRepository repository;
  late TravelDetailsController controller;

  final now = DateTime.now();

  CreateFormRequestModel travelEndingIn(Duration offset) => CreateFormRequestModel(
    id: 'travel-1',
    travelName: 'Rio de Janeiro',
    budgetPlan: '1000',
    startDate: now.subtract(const Duration(days: 5)),
    endDate: now.add(offset),
  );

  setUpAll(() => registerFallbackValue(FakeExpenseModel()));

  setUp(() {
    repository = MockExpenseRepository();
    controller = TravelDetailsController(expenseRepository: repository);

    when(
      () => repository.getExpenses(travelId: any(named: 'travelId')),
    ).thenAnswer((_) async => const Success(<ExpenseModel>[]));
  });

  group('finished travels are read only', () {
    test('refuses to add an expense once the last day is over', () async {
      await controller.loadExpenses(travel: travelEndingIn(const Duration(days: -1)));

      final added = await controller.addExpense(
        description: 'Dinner',
        amount: 50,
        category: ExpenseCategory.food,
        date: now,
      );

      expect(added, isFalse);
      expect(controller.value, isA<TravelDetailsError>());
      verifyNever(() => repository.createExpense(expense: any(named: 'expense')));
    });

    test('still accepts an expense on the last day of the travel', () async {
      final travel = CreateFormRequestModel(
        id: 'travel-1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '1000',
        startDate: now.subtract(const Duration(days: 5)),
        // ends today: the travel only closes after the day is over
        endDate: DateTime(now.year, now.month, now.day),
      );

      when(() => repository.createExpense(expense: any(named: 'expense'))).thenAnswer((
        invocation,
      ) async {
        return Success(invocation.namedArguments[#expense] as ExpenseModel);
      });

      await controller.loadExpenses(travel: travel);

      final added = await controller.addExpense(
        description: 'Dinner',
        amount: 50,
        category: ExpenseCategory.food,
        date: now,
      );

      expect(added, isTrue);
      verify(() => repository.createExpense(expense: any(named: 'expense'))).called(1);
    });

    test('accepts an expense while the travel is still running', () async {
      when(() => repository.createExpense(expense: any(named: 'expense'))).thenAnswer((
        invocation,
      ) async {
        return Success(invocation.namedArguments[#expense] as ExpenseModel);
      });

      await controller.loadExpenses(travel: travelEndingIn(const Duration(days: 3)));

      final added = await controller.addExpense(
        description: 'Dinner',
        amount: 50,
        category: ExpenseCategory.food,
        date: now,
      );

      expect(added, isTrue);
    });
  });

  test('reads the budget from the travel', () async {
    await controller.loadExpenses(travel: travelEndingIn(const Duration(days: 3)));

    expect((controller.value as TravelDetailsLoaded).budget, 1000);
  });
}

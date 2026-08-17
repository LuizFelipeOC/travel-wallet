import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/di/di.dart';
import 'package:travel_wallet/app/features/travel_details/data/erros/travel_details_erros.dart';
import 'package:travel_wallet/app/features/travel_details/data/models/expense.dart';
import 'package:travel_wallet/app/features/travel_details/data/repositories/expense_repository.dart';
import 'package:travel_wallet/app/features/travel_details/presentation/travel_details_screen.dart';
import 'package:travel_wallet/app/features/travel_details/state/travel_details_controller.dart';
import 'package:travel_wallet/app/features/travel_details/widgets/category_filter.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/l10n/app_localizations.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

class FakeExpenseModel extends Fake implements ExpenseModel {}

void main() {
  late MockExpenseRepository repository;

  final now = DateTime.now();

  /// A travel that is still running, so expenses can be added to it.
  final travel = CreateFormRequestModel(
    id: 'travel-1',
    travelName: 'Rio de Janeiro',
    budgetPlan: '1000',
    startDate: now.subtract(const Duration(days: 1)),
    endDate: now.add(const Duration(days: 7)),
  );

  /// A travel whose last day is already gone.
  final finishedTravel = CreateFormRequestModel(
    id: 'travel-1',
    travelName: 'Rio de Janeiro',
    budgetPlan: '1000',
    startDate: now.subtract(const Duration(days: 30)),
    endDate: now.subtract(const Duration(days: 2)),
  );

  ExpenseModel expense(String id, double amount, ExpenseCategory category) => ExpenseModel(
    id: id,
    travelId: 'travel-1',
    description: 'Expense $id',
    amount: amount,
    category: category,
    date: now,
  );

  setUpAll(() => registerFallbackValue(FakeExpenseModel()));

  setUp(() async {
    repository = MockExpenseRepository();

    await getIt.reset();
    getIt.registerFactory<TravelDetailsController>(
      () => TravelDetailsController(expenseRepository: repository),
    );
  });

  tearDown(() async => getIt.reset());

  Widget app({CreateFormRequestModel? which}) => MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: TravelDetailsScreen(travel: which ?? travel),
  );

  Finder chip(String label) =>
      find.descendant(of: find.byType(CategoryFilter), matching: find.textContaining(label));

  void stubExpenses(List<ExpenseModel> expenses) {
    when(
      () => repository.getExpenses(travelId: 'travel-1'),
    ).thenAnswer((_) async => Success(expenses));
  }

  testWidgets('shows spent against the budget', (tester) async {
    stubExpenses([
      expense('1', 250, ExpenseCategory.food),
      expense('2', 150, ExpenseCategory.transport),
    ]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('\$400.00 of \$1,000.00'), findsOneWidget);
    expect(find.text('40%'), findsOneWidget);
    expect(find.text('\$600.00 left'), findsOneWidget);
  });

  testWidgets('reports going over the budget', (tester) async {
    stubExpenses([expense('1', 1200, ExpenseCategory.food)]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('100%'), findsOneWidget);
    expect(find.text('\$200.00 over budget'), findsOneWidget);
  });

  testWidgets('filters the list by category and back to all', (tester) async {
    stubExpenses([
      expense('1', 250, ExpenseCategory.food),
      expense('2', 150, ExpenseCategory.transport),
    ]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Expense 1'), findsOneWidget);
    expect(find.text('Expense 2'), findsOneWidget);

    await tester.tap(chip('Transport'));
    await tester.pumpAndSettle();

    expect(find.text('Expense 1'), findsNothing);
    expect(find.text('Expense 2'), findsOneWidget);

    // the totals keep counting every expense, only the list is filtered
    expect(find.text('\$400.00 of \$1,000.00'), findsOneWidget);

    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    expect(find.text('Expense 1'), findsOneWidget);
  });

  testWidgets('only offers categories that have expenses', (tester) async {
    stubExpenses([expense('1', 250, ExpenseCategory.food)]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(chip('Food'), findsOneWidget);
    expect(chip('Lodging'), findsNothing);
  });

  testWidgets('shows a dedicated message when the filtered category is empty', (tester) async {
    stubExpenses([expense('1', 250, ExpenseCategory.food)]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(chip('Food'));
    await tester.pumpAndSettle();

    // filtering to the only category keeps its expense visible
    expect(find.text('Expense 1'), findsOneWidget);
    expect(find.text('No expenses in this category'), findsNothing);
  });

  testWidgets('empty state when the trip has no expenses', (tester) async {
    stubExpenses([]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('No expenses yet'), findsOneWidget);
    expect(find.text('All'), findsNothing);
  });

  testWidgets('adds an expense through the sheet and reloads', (tester) async {
    stubExpenses([]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add expense'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Hotel');
    await tester.enterText(find.byType(TextFormField).at(1), '320.50');

    final created = expense('9', 320.5, ExpenseCategory.food);
    when(
      () => repository.createExpense(expense: any(named: 'expense')),
    ).thenAnswer((_) async => Success(created));
    stubExpenses([created]);

    await tester.tap(find.text('Save expense'));
    await tester.pumpAndSettle();

    final sent =
        verify(
              () => repository.createExpense(expense: captureAny(named: 'expense')),
            ).captured.single
            as ExpenseModel;

    expect(sent.description, 'Hotel');
    expect(sent.amount, 320.5);
    expect(sent.travelId, 'travel-1');

    expect(find.text('\$320.50 of \$1,000.00'), findsOneWidget);
  });

  testWidgets('counts the totals up instead of jumping to the final value', (tester) async {
    stubExpenses([expense('1', 500, ExpenseCategory.food)]);

    await tester.pumpWidget(app());
    await tester.pump();
    await tester.pump();

    // part way through the animation the final amount is not on screen yet
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text('\$500.00 of \$1,000.00'), findsNothing);
    expect(find.text('50%'), findsNothing);

    await tester.pumpAndSettle();
    expect(find.text('\$500.00 of \$1,000.00'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
  });

  testWidgets('grows from the previous total when an expense is added', (tester) async {
    final first = expense('1', 400, ExpenseCategory.food);
    stubExpenses([first]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(find.text('\$400.00 of \$1,000.00'), findsOneWidget);

    final second = expense('2', 100, ExpenseCategory.transport);
    when(
      () => repository.createExpense(expense: any(named: 'expense')),
    ).thenAnswer((_) async => Success(second));
    stubExpenses([first, second]);

    await tester.tap(find.text('Add expense'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Bus');
    await tester.enterText(find.byType(TextFormField).at(1), '100');
    await tester.tap(find.text('Save expense'));
    await tester.pump();
    await tester.pump();

    // mid-flight it is neither the old nor the new total
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text('\$400.00 of \$1,000.00'), findsNothing);
    expect(find.text('\$500.00 of \$1,000.00'), findsNothing);

    await tester.pumpAndSettle();
    expect(find.text('\$500.00 of \$1,000.00'), findsOneWidget);
  });

  testWidgets('a finished travel cannot take new expenses', (tester) async {
    stubExpenses([expense('1', 250, ExpenseCategory.food)]);

    await tester.pumpWidget(app(which: finishedTravel));
    await tester.pumpAndSettle();

    expect(find.text('This trip has ended, so no new expenses can be added.'), findsOneWidget);
    expect(find.text('Add expense'), findsNothing);
  });

  testWidgets('a running travel keeps the add button and no warning', (tester) async {
    stubExpenses([expense('1', 250, ExpenseCategory.food)]);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Add expense'), findsOneWidget);
    expect(find.text('This trip has ended, so no new expenses can be added.'), findsNothing);
  });

  testWidgets('surfaces a load failure', (tester) async {
    when(
      () => repository.getExpenses(travelId: 'travel-1'),
    ).thenAnswer((_) async => Failure(ExpenseLoadError(message: 'boom')));

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('boom'), findsOneWidget);
  });
}

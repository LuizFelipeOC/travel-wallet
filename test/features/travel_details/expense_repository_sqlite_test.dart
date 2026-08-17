import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/core/database/migrations/create_expense_table_migration.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/travel_details/data/models/expense.dart';
import 'package:travel_wallet/app/features/travel_details/data/repositories/expense_repository.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

import '../../helpers/in_memory_database.dart';

void main() {
  sqfliteFfiInit();

  late Database database;
  late ExpenseRepository repository;
  late CreateFormRepository travelRepository;

  ExpenseModel expense({
    String id = '1',
    String travelId = 'travel-1',
    double amount = 100,
    ExpenseCategory category = ExpenseCategory.food,
    DateTime? date,
  }) {
    return ExpenseModel(
      id: id,
      travelId: travelId,
      description: 'Dinner',
      amount: amount,
      category: category,
      date: date ?? DateTime(2026, 7, 27),
    );
  }

  setUp(() async {
    database = await openInMemoryDatabase();

    final helper = DatabaseCrudHelper(appDatabase: InMemoryAppDatabase(database));
    repository = ExpenseRepository(databaseCrudHelper: helper);
    travelRepository = CreateFormRepository(databaseCrudHelper: helper);

    await travelRepository.createTravel(
      formRequest: CreateFormRequestModel(
        id: 'travel-1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 8, 2),
      ),
    );
  });

  tearDown(() async => database.close());

  test('round trips an expense through the real schema', () async {
    final created = await repository.createExpense(expense: expense(amount: 120.5));
    expect(created, isA<Success<ExpenseModel>>());

    final result = await repository.getExpenses(travelId: 'travel-1');
    final expenses = (result as Success<List<ExpenseModel>>).data;

    expect(expenses, hasLength(1));
    expect(expenses.first.amount, 120.5);
    expect(expenses.first.category, ExpenseCategory.food);
    expect(expenses.first.date, DateTime(2026, 7, 27));
  });

  test('only returns expenses of the requested travel', () async {
    await travelRepository.createTravel(
      formRequest: CreateFormRequestModel(
        id: 'travel-2',
        travelName: 'Buenos Aires',
        budgetPlan: '1000',
        startDate: DateTime(2026, 3, 10),
        endDate: DateTime(2026, 3, 18),
      ),
    );

    await repository.createExpense(expense: expense(id: '1'));
    await repository.createExpense(
      expense: expense(id: '2', travelId: 'travel-2'),
    );

    final result = await repository.getExpenses(travelId: 'travel-1');

    expect((result as Success<List<ExpenseModel>>).data.map((e) => e.id), ['1']);
  });

  test('lists the most recent expenses first', () async {
    await repository.createExpense(
      expense: expense(id: '1', date: DateTime(2026, 7, 26)),
    );
    await repository.createExpense(
      expense: expense(id: '2', date: DateTime(2026, 7, 30)),
    );

    final result = await repository.getExpenses(travelId: 'travel-1');

    expect((result as Success<List<ExpenseModel>>).data.map((e) => e.id), ['2', '1']);
  });

  test('rejects an empty description and a non positive amount', () async {
    final noDescription = await repository.createExpense(
      expense: ExpenseModel(
        id: '1',
        travelId: 'travel-1',
        description: '   ',
        amount: 10,
        category: ExpenseCategory.food,
        date: DateTime(2026, 7, 27),
      ),
    );

    final zeroAmount = await repository.createExpense(expense: expense(amount: 0));

    expect(noDescription, isA<Failure>());
    expect(zeroAmount, isA<Failure>());

    final rows = await database.query(CreateExpenseTableMigration.tableName);
    expect(rows, isEmpty);
  });

  test('removes an expense', () async {
    await repository.createExpense(expense: expense());

    await repository.deleteExpense(id: '1');

    final result = await repository.getExpenses(travelId: 'travel-1');
    expect((result as Success<List<ExpenseModel>>).data, isEmpty);
  });

  test('deleting the travel cascades to its expenses', () async {
    await repository.createExpense(expense: expense());

    await database.delete(
      CreateFormTableMigration.tableName,
      where: 'id = ?',
      whereArgs: ['travel-1'],
    );

    final rows = await database.query(CreateExpenseTableMigration.tableName);
    expect(rows, isEmpty);
  });
}

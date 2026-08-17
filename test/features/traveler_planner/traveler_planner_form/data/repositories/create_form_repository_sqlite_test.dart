import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

import '../../../../../helpers/in_memory_database.dart';

void main() {
  sqfliteFfiInit();

  late Database database;
  late CreateFormRepository repository;

  setUp(() async {
    database = await openInMemoryDatabase();
    repository = CreateFormRepository(
      databaseCrudHelper: DatabaseCrudHelper(appDatabase: InMemoryAppDatabase(database)),
    );
  });

  tearDown(() async => database.close());

  test('table created by the migration accepts the model as written', () async {
    final request = CreateFormRequestModel(
      id: '1',
      travelName: 'Rio de Janeiro',
      budgetPlan: '2000.50',
      startDate: DateTime(2026, 7, 26),
      endDate: DateTime(2026, 8, 2),
    );

    final result = await repository.createTravel(formRequest: request);
    expect(result, isA<Success<CreateFormRequestModel>>());

    final rows = await database.query(CreateFormTableMigration.tableName);
    expect(rows, hasLength(1));
    expect(rows.first['travel_name'], 'Rio de Janeiro');
    expect(rows.first['start_date'], '2026-07-26T00:00:00.000');
  });

  test('round trips a saved travel back through getTravels', () async {
    await repository.createTravel(
      formRequest: CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000.50',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 8, 2),
      ),
    );

    final result = await repository.getTravels();

    expect(result, isA<Success<List<CreateFormRequestModel>>>());

    final travels = (result as Success<List<CreateFormRequestModel>>).data;
    expect(travels, hasLength(1));
    expect(travels.first.travelName, 'Rio de Janeiro');
    expect(travels.first.budgetPlan, '2000.50');
    expect(travels.first.startDate, DateTime(2026, 7, 26));
    expect(travels.first.endDate, DateTime(2026, 8, 2));
  });

  test('lists the most recent travels first', () async {
    for (final entry in {'1': DateTime(2026, 1, 10), '2': DateTime(2026, 9, 5)}.entries) {
      await repository.createTravel(
        formRequest: CreateFormRequestModel(
          id: entry.key,
          travelName: 'Travel ${entry.key}',
          budgetPlan: '100',
          startDate: entry.value,
          endDate: entry.value.add(const Duration(days: 3)),
        ),
      );
    }

    final result = await repository.getTravels() as Success<List<CreateFormRequestModel>>;

    expect(result.data.map((travel) => travel.id), ['2', '1']);
  });

  test('updates an existing travel in place', () async {
    final original = CreateFormRequestModel(
      id: '1',
      travelName: 'Rio de Janeiro',
      budgetPlan: '2000',
      startDate: DateTime(2026, 7, 26),
      endDate: DateTime(2026, 8, 2),
    );

    await repository.createTravel(formRequest: original);

    final edited = CreateFormRequestModel(
      id: '1',
      travelName: 'Rio de Janeiro - reprogramada',
      budgetPlan: '3500',
      startDate: DateTime(2026, 9, 1),
      endDate: DateTime(2026, 9, 10),
    );

    final result = await repository.updateTravel(formRequest: edited);
    expect(result, isA<Success<CreateFormRequestModel>>());

    final travels = (await repository.getTravels() as Success<List<CreateFormRequestModel>>).data;

    expect(travels, hasLength(1));
    expect(travels.first.travelName, 'Rio de Janeiro - reprogramada');
    expect(travels.first.budgetPlan, '3500');
    expect(travels.first.endDate, DateTime(2026, 9, 10));
  });

  test('deletes a travel', () async {
    await repository.createTravel(
      formRequest: CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 8, 2),
      ),
    );

    final result = await repository.deleteTravel(id: '1');
    expect(result, isA<Success<String>>());

    final travels = (await repository.getTravels() as Success<List<CreateFormRequestModel>>).data;
    expect(travels, isEmpty);
  });

  test('rejects an edit that leaves the travel invalid', () async {
    final result = await repository.updateTravel(
      formRequest: CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 9, 10),
        endDate: DateTime(2026, 9, 1),
      ),
    );

    expect(result, isA<Failure>());
  });

  test('returns an empty list when nothing was saved yet', () async {
    final result = await repository.getTravels() as Success<List<CreateFormRequestModel>>;

    expect(result.data, isEmpty);
  });
}

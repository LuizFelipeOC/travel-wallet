import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';
import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/erros/traveler_planner_form_erros.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/repositories/create_form_repository.dart';

class MockDatabaseCrudHelper extends Mock implements DatabaseCrudHelper {}

void main() {
  group('CreateFormRepository', () {
    late MockDatabaseCrudHelper databaseCrudHelper;
    late CreateFormRepository repository;

    setUp(() {
      databaseCrudHelper = MockDatabaseCrudHelper();
      repository = CreateFormRepository(databaseCrudHelper: databaseCrudHelper);
    });

    test('returns validation failure when travel name or budget is empty', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: '',
        budgetPlan: '',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Failure<CreateFormRequestModel, TravelerFormValidationError>>());
      verifyNever(
        () => databaseCrudHelper.insert(
          tableName: CreateFormTableMigration.tableName,
          values: any(named: 'values'),
        ),
      );
    });

    test('persists form data and returns success when request is valid', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      when(
        () => databaseCrudHelper.insert(
          tableName: CreateFormTableMigration.tableName,
          values: Map<String, Object?>.from(request.toJson()),
        ),
      ).thenAnswer((_) async => 1);

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Success<CreateFormRequestModel>>());
      expect((result as Success<CreateFormRequestModel>).data, same(request));
      verify(
        () => databaseCrudHelper.insert(
          tableName: CreateFormTableMigration.tableName,
          values: Map<String, Object?>.from(request.toJson()),
        ),
      ).called(1);
    });

    test('returns submission failure when database insert throws', () async {
      final request = CreateFormRequestModel(
        id: '1',
        travelName: 'Rio de Janeiro',
        budgetPlan: '2000',
        startDate: DateTime(2026, 7, 26),
        endDate: DateTime(2026, 7, 27),
      );

      when(
        () => databaseCrudHelper.insert(
          tableName: CreateFormTableMigration.tableName,
          values: Map<String, Object?>.from(request.toJson()),
        ),
      ).thenThrow(Exception('db error'));

      final result = await repository.createTravel(formRequest: request);

      expect(result, isA<Failure<CreateFormRequestModel, TravelerFormSubmissionError>>());
      final failure = result as Failure<CreateFormRequestModel, TravelerFormSubmissionError>;
      expect(failure.error.message, 'An unexpected error occurred.');
    });
  });
}

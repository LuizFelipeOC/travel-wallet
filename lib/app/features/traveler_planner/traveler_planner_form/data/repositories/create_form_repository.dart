import 'package:travel_wallet/app/core/result/result.dart';
import 'package:travel_wallet/app/core/database/database_crud_helper.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';
import 'package:travel_wallet/app/features/traveler_planner/traveler_planner_form/data/models/create_form_request.dart';
import '../erros/traveler_planner_form_erros.dart';

class CreateFormRepository {
  final DatabaseCrudHelper databaseCrudHelper;

  CreateFormRepository({required this.databaseCrudHelper});

  Future<Result<CreateFormRequestModel>> createTravel({
    required CreateFormRequestModel formRequest,
  }) async {
    if (formRequest.budgetPlan.isEmpty || formRequest.travelName.isEmpty) {
      return Failure(
        TravelerFormValidationError(message: 'Travel name and budget plan cannot be empty.'),
      );
    }

    if (formRequest.startDate.isAfter(formRequest.endDate)) {
      return Failure(TravelerFormValidationError(message: 'Start date cannot be after end date.'));
    }

    try {
      await databaseCrudHelper.insert(
        tableName: CreateFormTableMigration.tableName,
        values: Map<String, Object?>.from(formRequest.toJson()),
      );

      return Success(formRequest);
    } catch (e) {
      return Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.'));
    }
  }

  Future<Result<CreateFormRequestModel>> updateTravel({
    required CreateFormRequestModel formRequest,
  }) async {
    if (formRequest.budgetPlan.isEmpty || formRequest.travelName.isEmpty) {
      return Failure(
        TravelerFormValidationError(message: 'Travel name and budget plan cannot be empty.'),
      );
    }

    if (formRequest.startDate.isAfter(formRequest.endDate)) {
      return Failure(TravelerFormValidationError(message: 'Start date cannot be after end date.'));
    }

    try {
      await databaseCrudHelper.update(
        tableName: CreateFormTableMigration.tableName,
        values: Map<String, Object?>.from(formRequest.toJson()),
        where: 'id = ?',
        whereArgs: [formRequest.id],
      );

      return Success(formRequest);
    } catch (e) {
      return Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.'));
    }
  }

  Future<Result<String>> deleteTravel({required String id}) async {
    if (id.isEmpty) {
      return Failure(TravelerFormValidationError(message: 'Travel id cannot be empty.'));
    }

    try {
      await databaseCrudHelper.delete(
        tableName: CreateFormTableMigration.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return Success(id);
    } catch (e) {
      return Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.'));
    }
  }

  Future<Result<List<CreateFormRequestModel>>> getTravels() async {
    try {
      final rows = await databaseCrudHelper.query(
        tableName: CreateFormTableMigration.tableName,
        orderBy: 'start_date DESC',
      );

      return Success(rows.map(CreateFormRequestModel.fromJson).toList());
    } catch (e) {
      return Failure(TravelerFormSubmissionError(message: 'An unexpected error occurred.'));
    }
  }
}

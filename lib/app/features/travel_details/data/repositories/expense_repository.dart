import '../../../../core/database/database_crud_helper.dart';
import '../../../../core/database/migrations/create_expense_table_migration.dart';
import '../../../../core/result/result.dart';
import '../erros/travel_details_erros.dart';
import '../models/expense.dart';

class ExpenseRepository {
  final DatabaseCrudHelper databaseCrudHelper;

  ExpenseRepository({required this.databaseCrudHelper});

  Future<Result<List<ExpenseModel>>> getExpenses({required String travelId}) async {
    if (travelId.isEmpty) {
      return Failure(ExpenseValidationError(message: 'Travel id cannot be empty.'));
    }

    try {
      final rows = await databaseCrudHelper.query(
        tableName: CreateExpenseTableMigration.tableName,
        where: 'travel_id = ?',
        whereArgs: [travelId],
        orderBy: 'date DESC',
      );

      return Success(rows.map(ExpenseModel.fromJson).toList());
    } catch (e) {
      return Failure(ExpenseLoadError(message: 'An unexpected error occurred.'));
    }
  }

  Future<Result<ExpenseModel>> createExpense({required ExpenseModel expense}) async {
    if (expense.description.trim().isEmpty) {
      return Failure(ExpenseValidationError(message: 'Description cannot be empty.'));
    }

    if (expense.amount <= 0) {
      return Failure(ExpenseValidationError(message: 'Amount must be greater than zero.'));
    }

    try {
      await databaseCrudHelper.insert(
        tableName: CreateExpenseTableMigration.tableName,
        values: Map<String, Object?>.from(expense.toJson()),
      );

      return Success(expense);
    } catch (e) {
      return Failure(ExpenseSubmissionError(message: 'An unexpected error occurred.'));
    }
  }

  Future<Result<String>> deleteExpense({required String id}) async {
    try {
      await databaseCrudHelper.delete(
        tableName: CreateExpenseTableMigration.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return Success(id);
    } catch (e) {
      return Failure(ExpenseSubmissionError(message: 'An unexpected error occurred.'));
    }
  }
}

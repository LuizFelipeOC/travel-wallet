import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_wallet/app/core/database/app_database.dart';
import 'package:travel_wallet/app/core/database/migrations/create_expense_table_migration.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';

/// Opens an in-memory database using the production migration, so the tests
/// run against the same schema the app ships.
Future<Database> openInMemoryDatabase() {
  return databaseFactoryFfi.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      version: 2,
      onConfigure: (db) async => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        await CreateFormTableMigration.create(db);
        await CreateExpenseTableMigration.create(db);
      },
    ),
  );
}

class InMemoryAppDatabase implements AppDatabase {
  final Database database;

  InMemoryAppDatabase(this.database);

  @override
  Future<Database> getDatabase() async => database;

  @override
  Future<Database> initializeDatabase() async => database;

  @override
  Future<void> closeDatabase() => database.close();
}

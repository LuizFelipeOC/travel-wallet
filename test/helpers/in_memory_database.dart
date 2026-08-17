import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_wallet/app/core/database/app_database.dart';
import 'package:travel_wallet/app/core/database/migrations/create_form_table_migration.dart';

/// Opens an in-memory database using the production migration, so the tests
/// run against the same schema the app ships.
Future<Database> openInMemoryDatabase() {
  return databaseFactoryFfi.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async => CreateFormTableMigration.create(db),
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

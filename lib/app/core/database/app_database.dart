import 'package:sqflite/sqflite.dart';

import 'migrations/create_expense_table_migration.dart';
import 'migrations/create_form_table_migration.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase _instance = AppDatabase._();

  factory AppDatabase() => _instance;

  Database? _database;

  Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final dbPath = '$databasePath/travel_wallet.db';

    _database ??= await openDatabase(
      dbPath,
      version: 2,
      onConfigure: (db) async {
        // Required for the expense -> travel cascade to be enforced.
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await CreateFormTableMigration.create(db);
        await CreateExpenseTableMigration.create(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await CreateExpenseTableMigration.create(db);
        }
      },
    );

    return _database!;
  }

  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    return initializeDatabase();
  }
}

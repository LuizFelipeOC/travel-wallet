import 'package:sqflite/sqflite.dart';

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
      version: 1,
      onCreate: (db, version) async {
        await CreateFormTableMigration.create(db);
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

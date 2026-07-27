import 'package:sqflite/sqflite.dart';

class CreateFormTableMigration {
  static const tableName = 'travel_forms';

  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY NOT NULL,
        travel_name TEXT NOT NULL,
        budget_plan TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL
      )
      ''');
  }
}

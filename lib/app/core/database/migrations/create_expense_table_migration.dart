import 'package:sqflite/sqflite.dart';

import 'create_form_table_migration.dart';

class CreateExpenseTableMigration {
  static const tableName = 'travel_expenses';

  static Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY NOT NULL,
        travel_id TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (travel_id) REFERENCES ${CreateFormTableMigration.tableName} (id)
          ON DELETE CASCADE
      )
      ''');

    await db.execute('''
      CREATE INDEX idx_${tableName}_travel_id ON $tableName (travel_id)
      ''');
  }
}

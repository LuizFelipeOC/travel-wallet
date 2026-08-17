import 'package:sqflite/sqflite.dart';

import 'app_database.dart';

class DatabaseCrudHelper {
  final AppDatabase appDatabase;

  DatabaseCrudHelper({required this.appDatabase});

  Future<Database> get _database => appDatabase.getDatabase();

  Future<int> insert({
    required String tableName,
    required Map<String, Object?> values,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace,
  }) async {
    return (await _database).insert(tableName, values, conflictAlgorithm: conflictAlgorithm);
  }

  Future<List<Map<String, Object?>>> query({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    return (await _database).query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  Future<int> update({
    required String tableName,
    required Map<String, Object?> values,
    required String where,
    required List<Object?> whereArgs,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace,
  }) async {
    return (await _database).update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  Future<int> delete({
    required String tableName,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    return (await _database).delete(tableName, where: where, whereArgs: whereArgs);
  }
}

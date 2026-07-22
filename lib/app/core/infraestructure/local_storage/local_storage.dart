import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_interface.dart';

class Localstorage implements ILocalStorage {
  @override
  Future<LocalStorageResult> get({required String key}) async {
    if (key.isEmpty) {
      return LocalStorageFailure(message: 'Key cannot be empty');
    }

    final sharedPreferences = await SharedPreferences.getInstance();

    return LocalStorageSuccess(data: sharedPreferences.get(key));
  }

  @override
  Future<LocalStorageResult<dynamic>> set({required String key, required dynamic value}) async {
    if (key.isEmpty) {
      return Future.value(LocalStorageFailure(message: 'Key cannot be empty'));
    }

    final sharedPreferences = await SharedPreferences.getInstance();

    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }

    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    return Future.value(LocalStorageSuccess(data: value));
  }
}

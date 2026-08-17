import 'local_storage_result.dart';

export 'local_storage_result.dart';

abstract interface class ILocalStorage<T> {
  Future<LocalStorageResult> get({required String key});
  Future<LocalStorageResult> set({required String key, required T value});
}

abstract interface class ILocalStorage<T> {
  Future<LocalStorageResult> get({required String key});
  Future<LocalStorageResult> set({required String key, required T value});
}

sealed class LocalStorageResult<T> {}

class LocalStorageSuccess<T> extends LocalStorageResult<T> {
  final T data;

  LocalStorageSuccess({required this.data});
}

class LocalStorageFailure<T> extends LocalStorageResult<T> {
  final String message;

  LocalStorageFailure({required this.message});
}

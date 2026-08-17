part of 'local_storage_result.dart';

class LocalStorageSuccess<T> extends LocalStorageResult<T> {
  final T data;

  LocalStorageSuccess({required this.data});
}

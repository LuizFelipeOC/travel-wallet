part of 'local_storage_result.dart';

class LocalStorageFailure<T> extends LocalStorageResult<T> {
  final String message;

  LocalStorageFailure({required this.message});
}

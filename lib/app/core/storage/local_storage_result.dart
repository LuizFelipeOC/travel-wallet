/// `LocalStorageResult` is sealed, so its subtypes are split with `part` to
/// stay in the same library.
library;

part 'local_storage_failure.dart';
part 'local_storage_success.dart';

sealed class LocalStorageResult<T> {}

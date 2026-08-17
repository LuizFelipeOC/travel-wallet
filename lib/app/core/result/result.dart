/// `Result` is sealed, so its subtypes have to live in the same library for
/// exhaustive switches to work. They are split with `part` instead of separate
/// libraries for that reason.
library;

part 'failure.dart';
part 'success.dart';

sealed class Result<T> {
  const Result();
}

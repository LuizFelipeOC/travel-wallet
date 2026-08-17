part of 'result.dart';

final class Failure<T, E extends Object> extends Result<T> {
  final E error;

  const Failure(this.error);
}

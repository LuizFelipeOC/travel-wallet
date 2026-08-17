part of 'result.dart';

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

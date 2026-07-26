sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T, E extends Object> extends Result<T> {
  final E error;

  const Failure(this.error);
}

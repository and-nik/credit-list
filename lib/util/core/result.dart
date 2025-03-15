sealed class Result<T> {
  const Result();

  R fold<R>(
      R Function(Exception exception) onFailure,
      R Function(T value) onSuccess,
  ) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).value);
    } else if (this is Failure<T>) {
      return onFailure((this as Failure<T>).exception);
    }
    throw StateError("Unknown Result state");
  }
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Exception exception;
  const Failure(this.exception);
}
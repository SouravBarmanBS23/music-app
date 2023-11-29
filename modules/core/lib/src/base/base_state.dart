enum Status {
  initial,
  loading,
  success,
  error,
}

class BaseState<T> {
  BaseState({
    this.status,
    this.message,
    this.data,
  });

  BaseState.initial()
      : status = Status.initial,
        message = null,
        data = null;

  BaseState.loading()
      : status = Status.loading,
        message = null,
        data = null;

  final Status? status;
  final String? message;
  final T? data;

  BaseState<T> copyWith({
    Status? status,
    String? message,
    T? data,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

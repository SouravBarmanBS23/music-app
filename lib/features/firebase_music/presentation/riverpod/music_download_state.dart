part of './music_dowload_provider.dart';

class BaseState<T> {
  BaseState({
    this.message,
    this.data,
  });

  final String? message;
  final List<T>? data;

  BaseState<T> copyWith({
    String? message,
    List<T>? data,
  }) {
    return BaseState<T>(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

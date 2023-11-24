part of './get_audio_provider.dart';

enum MusicStatus {
  initial,
  loading,
  success,
  error,
}

class GetAudioState<T> {
  GetAudioState({
    this.status,
    this.message,
    this.data,
  });

  GetAudioState.initial()
      : status = MusicStatus.initial,
        message = null,
        data = null;

  GetAudioState.loading()
      : status = MusicStatus.loading,
        message = null,
        data = null;

  final MusicStatus? status;
  final String? message;
  final T? data;

  GetAudioState<T> copyWith({
    MusicStatus? status,
    String? message,
    T? data,
  }) {
    return GetAudioState<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

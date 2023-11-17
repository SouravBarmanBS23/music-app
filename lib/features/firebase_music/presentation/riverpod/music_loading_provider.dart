import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MusicLoadingState { initial, loading, success, error }

final musicLoadingProvider =
    NotifierProvider<MusicDownloadStateNotifier, MusicLoadingState>(
  MusicDownloadStateNotifier.new,
);

class MusicDownloadStateNotifier extends Notifier<MusicLoadingState> {
  @override
  MusicLoadingState build() {
    return MusicLoadingState.initial;
  }

  void setLoading() {
    state = MusicLoadingState.loading;
  }

  void setSuccess() {
    state = MusicLoadingState.success;
  }
}

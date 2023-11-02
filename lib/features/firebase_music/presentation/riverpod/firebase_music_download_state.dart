part of './firebase_music_download_provider.dart';

class FirebaseMusicDownloadState {
  FirebaseMusicDownloadState({
    required this.isLoading,
    required this.isCompleted,
    required this.index,
  });

  final bool isLoading;
  final bool isCompleted;
  final int index;

  FirebaseMusicDownloadState copyWith({

    bool? isLoading,
    bool? isCompleted,
    int? index,
  }) {
    return FirebaseMusicDownloadState(
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      index: index ?? this.index,
    );
  }
}

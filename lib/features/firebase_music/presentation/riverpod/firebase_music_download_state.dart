part of './firebase_music_download_provider.dart';

class FirebaseMusicDownloadState {
  FirebaseMusicDownloadState({
    required this.isLoading,
    required this.isCompleted,
    required this.musicName,
    required this.alreadyExist,
  });

  final bool isLoading;
  final bool isCompleted;
  final String musicName;
  final bool alreadyExist;

  FirebaseMusicDownloadState copyWith({
    bool? isLoading,
    bool? isCompleted,
    String? musicName,
    bool? alreadyExist,
  }) {
    return FirebaseMusicDownloadState(
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      musicName: musicName ?? this.musicName,
      alreadyExist: alreadyExist ?? this.alreadyExist,
    );
  }
}

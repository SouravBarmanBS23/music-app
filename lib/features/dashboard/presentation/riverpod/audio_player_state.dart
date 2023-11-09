part of './audio_player_provider.dart';

class AudioPlayerStateTest {
  AudioPlayerStateTest({
    required this.playIndex,
    required this.isPlaying,
  });

  final int playIndex;
  final bool isPlaying;

  AudioPlayerStateTest copyWith({
    int? playIndex,
    bool? isPlaying,
  }) {
    return AudioPlayerStateTest(
      playIndex: playIndex ?? this.playIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

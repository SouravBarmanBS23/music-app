class AudioPlayerState {
  AudioPlayerState({
    required this.playIndex,
    required this.isPlaying,

  });

  final int playIndex;
  final bool isPlaying;


  AudioPlayerState copyWith({
    int? playIndex,
    bool? isPlaying,

  }) {
    return AudioPlayerState(
      playIndex: playIndex ?? this.playIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
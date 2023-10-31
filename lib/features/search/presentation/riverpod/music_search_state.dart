class MusicSearchState {
  MusicSearchState({
    required this.isFound,
  });

  final int isFound;

  MusicSearchState copyWith({
    int? isFound,
  }) {
    return MusicSearchState(
      isFound: isFound ?? this.isFound,
    );
  }
}

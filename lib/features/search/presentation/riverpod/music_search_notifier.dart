import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_app/features/search/presentation/riverpod/music_search_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicSearchNotifier extends Notifier<MusicSearchState> {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  List<SongModel> filteredSongs = [];
  List<SongModel> songs = [];

  @override
  MusicSearchState build() {
    return MusicSearchState(isFound: 2);
  }

  Future<void> getSongs() async {
    songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<void> filterSongs(String searchQuery) async {
    filteredSongs = songs
        .where(
          (song) => song.displayNameWOExt
              .toLowerCase()
              .contains(searchQuery.toLowerCase()),
        )
        .toList();

    if (filteredSongs.isEmpty && searchQuery.isNotEmpty) {
      filteredSongs.clear();
      state = MusicSearchState(isFound: 3);
    } else if (filteredSongs.isNotEmpty && searchQuery.isNotEmpty) {
      state = MusicSearchState(isFound: 1);
    } else {
      filteredSongs.clear();
      state = MusicSearchState(isFound: 2);
    }
  }
}

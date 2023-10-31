import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/search/presentation/riverpod/music_search_notifier.dart';
import 'package:music_app/features/search/presentation/riverpod/music_search_state.dart';

final musicSearchProvider =
    NotifierProvider<MusicSearchNotifier, MusicSearchState>(
  MusicSearchNotifier.new,
);

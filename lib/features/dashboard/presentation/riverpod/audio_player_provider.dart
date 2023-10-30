import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_notifier.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_state.dart';

final audioPlayerProvider =
    NotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
  AudioPlayerNotifier.new,
);

final durationProvider = StateProvider((ref) => '');
final positionProvider = StateProvider((ref) => '');

final valueProvider = StateProvider((ref) => 0.0);
final maxProvider = StateProvider((ref) => 0.0);

final totalSongs = StateProvider((ref) => 0);
final permissionGranted = StateProvider((ref) => 0);

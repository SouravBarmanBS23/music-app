import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

part './audio_player_notifier.dart';
part './audio_player_state.dart';

final audioPlayerProvider =
    NotifierProvider<AudioPlayerNotifier, AudioPlayerStateTest>(
  AudioPlayerNotifier.new,
);

final durationProvider = StateProvider((ref) => '');
final positionProvider = StateProvider((ref) => '');

final valueProvider = StateProvider((ref) => 0.0);
final maxProvider = StateProvider((ref) => 0.0);

final totalSongs = StateProvider((ref) => 0);
final permissionGranted = StateProvider((ref) => 0);

import 'dart:io';

import 'package:core/src/music/music_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/constants/audio_directories.dart';
import 'package:path_provider/path_provider.dart';

part './get_audio_notifier.dart';
part './get_audio_state.dart';

final getAudioProvider = NotifierProvider<GetAudioNotifier, GetAudioState>(
  GetAudioNotifier.new,
);

import 'dart:io';

import 'package:core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/get_audio_provider.dart';
import 'package:music_app/features/firebase_music/data/model/firebase_music_model.dart';
import 'package:music_app/features/firebase_music/presentation/riverpod/music_dowload_provider.dart';
import 'package:music_app/features/firebase_music/presentation/riverpod/music_loading_provider.dart';
import 'package:path_provider/path_provider.dart';

part './firebase_music_download_notifier.dart';
part './firebase_music_download_state.dart';

final firebaseMusicDownloadProvider =
    NotifierProvider<FirebaseMusicDownloadNotifier, FirebaseMusicDownloadState>(
  FirebaseMusicDownloadNotifier.new,
);

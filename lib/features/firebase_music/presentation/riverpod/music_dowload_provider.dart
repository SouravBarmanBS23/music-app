import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:music_app/core/constants/hive_db.dart';

part './music_download_notifier.dart';
part './music_download_state.dart';

final musicDownloadListProvider =
    NotifierProvider<MusicDownloadNotifier, BaseState>(
  MusicDownloadNotifier.new,
);

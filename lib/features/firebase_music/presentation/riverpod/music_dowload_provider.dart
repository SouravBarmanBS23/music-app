import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

part './music_download_notifier.dart';
part './music_download_state.dart';

final musicDownloadListProvider = NotifierProvider<MusicDownloadNotifier, BaseState>(
  MusicDownloadNotifier.new,
);

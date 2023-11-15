import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_fetch_notifier.dart';

final dropboxMusicFetchProvider =
    NotifierProvider<DropBoxMusicFetchNotifier, DropboxAuthState>(
  DropBoxMusicFetchNotifier.new,
);

import 'dart:io';
import 'package:core/core.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/download_progress_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_auth_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_fetch_provider.dart';
import 'package:path_provider/path_provider.dart';

final dropBoxMusicDownloadProvider =
    NotifierProvider<DropboxMusicDownloadNotifier, DownloadState>(
  DropboxMusicDownloadNotifier.new,
);

enum DownloadState { initial, success, loading, error }

class DropboxMusicDownloadNotifier extends Notifier<DownloadState> {
  final list = List<dynamic>.empty(growable: true);
  final List<String> downloadItems = [];

  @override
  DownloadState build() {
    return DownloadState.initial;
  }

  Future listFolder(String path) async {
    final dropBoxAuthNotifier = ref.read(dropBoxAuthProvider.notifier);
    if (await dropBoxAuthNotifier.checkAuthorized(authorize: true)) {
      final result = await Dropbox.listFolder(path);
      list
        ..clear()
        ..addAll(result);
    }
  }

  Future downloadTest(String musicName, int index) async {
    final dropBoxFetchNotifier = ref.read(dropboxMusicFetchProvider.notifier);
    final progress = ref.read(downloadProgressProvider.notifier);
    if (await dropBoxFetchNotifier.checkAuthorized(authorize: true)) {
      final tempDir = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      final directory = Directory('${tempDir?.path}/dropbox/download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final filepath = '${tempDir?.path}/dropbox/download/$musicName';
      state = DownloadState.loading;
      await Dropbox.download('/$musicName', filepath, (downloaded, total) {
        progress.updateProgress((downloaded / total) * 100);
        cacheMusicName(musicName);
      });
      state = DownloadState.success;
      dropBoxFetchNotifier.updateDownloadStatus(index);
    }
  }

  Future<void> cacheMusicName(String musicName) async {
    final dropboxHiveBox =
        ref.read(cloudDownloadCacheServiceProvider(dropboxHiveBoxName));

    final boxIsOpen = await dropboxHiveBox.isOpened;
    if (boxIsOpen) {
      if (!dropboxHiveBox.isContain(musicName)) {
        dropboxHiveBox.putName(musicName, musicName);
      }
    }
  }

  Future<void> getCachedMusicName() async {
    final dropboxHiveBox =
        ref.read(cloudDownloadCacheServiceProvider(dropboxHiveBoxName));

    final boxIsOpen = await dropboxHiveBox.isOpened;
    final boxIsEmpty = dropboxHiveBox.isEmpty();
    final box = await dropboxHiveBox.box;

    if (boxIsOpen && !boxIsEmpty) {
      for (final key in box.keys) {
        final musicName = dropboxHiveBox.getKey(key);
        downloadItems.add(musicName!);
      }
    }
  }
}

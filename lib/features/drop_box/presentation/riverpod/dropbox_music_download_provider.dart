import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
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
    if (await dropBoxAuthNotifier.checkAuthorized(true)) {
      final result = await Dropbox.listFolder(path);
      list
        ..clear()
        ..addAll(result);
    }
  }

  Future downloadTest(String musicName,int index) async {
    final dropBoxFetchNotifier = ref.read(dropboxMusicFetchProvider.notifier);
    final progress = ref.read(downloadProgressProvider.notifier);
    if (await dropBoxFetchNotifier.checkAuthorized(true)) {
      final tempDir = await getExternalStorageDirectory();
      final directory = Directory('${tempDir?.path}/dropbox/download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final filepath = '${tempDir?.path}/dropbox/download/$musicName';
      print(filepath);
       state = DownloadState.loading;
      final result = await Dropbox.download('/$musicName', filepath,
          (downloaded, total) {
         //   progress.state = (downloaded / total) * 100;
         progress.updateProgress((downloaded / total) * 100);
     //  progress.state = result;
        print('progress ${(downloaded / total) * 100}');
        cacheMusicName(musicName);
      });
      // await ref.read(getAudioProvider.notifier).querySongs();
      state = DownloadState.success;
      dropBoxFetchNotifier.updateDownloadStatus(index);

      print(result);
      print(File(filepath).statSync());
    }
  }

  void cacheMusicName(String musicName) {
    final box = Hive.box<String>('dropbox-download');
    if (box.isOpen) {
      if (!box.containsKey(musicName)) {
        box.put(musicName, musicName);
      }
      // box.close();
    }
  }

  void getCachedMusicName() {
    final box = Hive.box<String>('dropbox-download');
    if (box.isOpen && box.isNotEmpty) {
      for (final key in box.keys) {
        final musicName = box.get(key);
        downloadItems.add(musicName!);
        print('getCachedMusicName : $musicName');
      }
    }
  }


}



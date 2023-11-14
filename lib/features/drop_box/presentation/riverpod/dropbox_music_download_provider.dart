import 'dart:io';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_auth_provider.dart';
import 'package:path_provider/path_provider.dart';

final dropBoxMusicDownloadProvider =
    NotifierProvider<DropboxMusicDownloadNotifier, DownloadState>(
  DropboxMusicDownloadNotifier.new,
);



enum DownloadState { initial, success, loading, error }

class DropboxMusicDownloadNotifier extends Notifier<DownloadState> {
  final list = List<dynamic>.empty(growable: true);

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

  Future downloadTest() async {
    final dropBoxAuthNotifier = ref.read(dropBoxAuthProvider.notifier);

    if (await dropBoxAuthNotifier.checkAuthorized(true)) {
      final tempDir = await getExternalStorageDirectory();
      final filepath = '${tempDir?.path}/dropbox/download/test_download.txt';
      print(filepath);

      final result = await Dropbox.download('/test_upload.txt', filepath,
          (downloaded, total) {
        print('progress $downloaded / $total');
      });

      print(result);
      print(File(filepath).statSync());
    }
  }

  Future getAccountInfo() async {
    final accountInfo = await Dropbox.getCurrentAccount();

    if (accountInfo != null) {
      print(accountInfo.name!.displayName);
      print(accountInfo.email);
      print(accountInfo.rootInfo!.homeNamespaceId);
      print(accountInfo.country);
    }
  }
}

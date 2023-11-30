part of './music_dowload_provider.dart';

class MusicDownloadNotifier extends Notifier<BaseState> {
  @override
  BaseState build() {
    return BaseState(data: []);
  }

  Future<void> cacheMusicName(String musicName) async {
    final firebaseBox =
        ref.read(cloudDownloadCacheServiceProvider(firebaseHiveBoxName));
    final box = await firebaseBox.isOpened;
    if (box) {
      if (!firebaseBox.isContain(musicName)) {
        firebaseBox.putName(musicName, musicName);
      }
    }
  }

  Future<bool> checkMusicExistOrNot(String musicName) async {
    final firebaseBox =
        ref.read(cloudDownloadCacheServiceProvider(firebaseHiveBoxName));

    final boxIsOpen = await firebaseBox.isOpened;
    final boxIsEmpty = firebaseBox.isEmpty();

    var isExist = false;
    if (boxIsOpen) {
      if (!boxIsEmpty) {
        if (firebaseBox.isContain(musicName)) {
          isExist = true;
        } else {
          isExist = false;
        }
      } else {
        isExist = false;
      }
    }
    return isExist;
  }

  Future<void> initialStoreOnHive() async {
    var directoryPath = await HiveDB.retrieveDirectoryFromHive();
    final box = Hive.box<String>('cloud-download');

    directoryPath = directoryPath ??
        '/storage/emulated/0/Android/data/com.example.musicapp.music_app/files/data/user/0/com.example.musicapp.music_app/files/';

    final files = await getFileNamesFromFolder(directoryPath);
    for (var i = 0; i < files.length; i++) {
      if (!box.containsKey(files[i])) {
        await box.put(files[i], files[i]);
      }
    }
  }

  Future<List<String>> getFileNamesFromFolder(String directoryPath) async {
    final fileNames = <String>[];

    final directory = Directory(directoryPath);

    if (directory.existsSync()) {
      final fileList = directory.listSync();

      for (final file in fileList) {
        if (file is File) {
          fileNames.add(file.path.split('/').last);
        }
      }
    }

    return fileNames;
  }
}

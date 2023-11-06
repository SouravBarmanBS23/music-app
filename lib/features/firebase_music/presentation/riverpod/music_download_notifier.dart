part of './music_dowload_provider.dart';

class MusicDownloadNotifier extends Notifier<BaseState> {
  final List<String> downloadItems = [];

  @override
  BaseState build() {
    getCachedMusicName();
    return BaseState(data: []);
  }

  void addItem(String musicName) {
    downloadItems.add(musicName);
  }

  void cacheMusicName(String musicName) {
    final box = Hive.box<String>('cloud-download');
    if (box.isOpen) {
      if (!box.containsKey(musicName)) {
        box.put(musicName, musicName);
      }
      // box.close();
    }
  }

  void getCachedMusicName() {
    final box = Hive.box<String>('cloud-download');
    if (box.isOpen && box.isNotEmpty) {
      for (final key in box.keys) {
        final musicName = box.get(key);
        downloadItems.add(musicName!);
      }
    }
  }

  bool checkMusicExistOrNot(String musicName) {
    final box = Hive.box<String>('cloud-download');
    var isExist = false;
    if (box.isOpen) {
      if (box.isNotEmpty) {
        if (box.containsKey(musicName)) {
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
    // Do something with the list of file names
    print('total files on this folder : ${files.length}');
    for (var i = 0; i < files.length; i++) {
      if (!box.containsKey(files[i])) {
        await box.put(files[i], files[i]);
      }
      print('${i + 1}. ${files[i]}');
    }
  }

  Future<List<String>> getFileNamesFromFolder(String directoryPath) async {
    final fileNames = <String>[];

    final directory =
        Directory(directoryPath); // Use the provided directory path

    if (directory.existsSync()) {
      final fileList =
          directory.listSync(); // Get a list of files in the directory

      for (final file in fileList) {
        if (file is File) {
          fileNames.add(file.path.split('/').last); // Extracting file name
        }
      }
    }

    return fileNames;
  }
}

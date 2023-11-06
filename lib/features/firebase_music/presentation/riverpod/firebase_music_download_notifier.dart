part of './firebase_music_download_provider.dart';

class FirebaseMusicDownloadNotifier
    extends Notifier<FirebaseMusicDownloadState> {
  late final Future<ListResult> futureFiles;

  @override
  FirebaseMusicDownloadState build() {
    getAllFiles();

    return FirebaseMusicDownloadState(
      isLoading: false,
      isCompleted: false,
      musicName: '',
      alreadyExist: false,
    );
  }

  Future<void> getAllFiles() async {
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  Future<void> downloadFile(Reference reference, int index) async {
    final notifier = ref.read(musicDownloadListProvider.notifier);

    final url = await reference.getDownloadURL();
    final isExist = notifier.checkMusicExistOrNot(reference.name);
    if (!isExist) {
      await FileDownloader.downloadFile(
        url: url,
        name: reference.name,
        onProgress: (count, total) {
          if (total == 100) {
            notifier
              ..addItem(reference.name)
              ..cacheMusicName(reference.name);

            state = FirebaseMusicDownloadState(
              isLoading: false,
              isCompleted: true,
              musicName: reference.name,
              alreadyExist: false,
            );
          } else {}
        },
        downloadDestination: DownloadDestinations.appFiles,
        onDownloadCompleted: (path) async {
          final directoryPath = path.substring(0, path.lastIndexOf('/'));
          await HiveDB.storeKeyInHive('$directoryPath/');
        },
      );
    } else {
      state = FirebaseMusicDownloadState(
        isLoading: false,
        isCompleted: false,
        musicName: reference.name,
        alreadyExist: true,
      );
    }
  }
}

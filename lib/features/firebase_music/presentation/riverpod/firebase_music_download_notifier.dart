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
      index: 0,
    );
  }

  Future<void> getAllFiles() async {
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  Future<void> downloadFile(Reference reference, int index) async {
    final notifier = ref.read(musicDownloadListProvider.notifier);

    final url = await reference.getDownloadURL();
    print('index number $index');
    // visible to gallery
    // final tempDir = await getTemporaryDirectory();
    // final filePath = '${tempDir.path}/${ref.name}';
    //  await Dio().download(url, filePath);

    await FileDownloader.downloadFile(
      url: url,
      name: reference.name,
      onProgress: (count, total) {
        print('count $count');
        print('total $total');
        if (total == 100) {
          print('inside total');
          notifier..addItem(index)
          ..cacheMusicName(reference.name);
        } else {
          print('outside total');
        }
      },
    );
  }
}

class EachItem {
  const EachItem({
    required this.futureFiles,
    this.isSelected = true,
  });
  final bool isSelected;
  final Future<ListResult> futureFiles;
}

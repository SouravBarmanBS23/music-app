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
    final dio = Dio();
    final url = await reference.getDownloadURL();
    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();

    final isExist = await notifier.checkMusicExistOrNot(reference.name);
    if (!isExist) {
      await dio.download(
        url,
        '${directory?.path}/music/${reference.name}',
        onReceiveProgress: (rcv, total) {
          final received = rcv;
          final fileSize = total;
          final downloadPercentage = calculatePercentage(received, fileSize);

          if (downloadPercentage == 100.0) {
            notifier.cacheMusicName(reference.name);

            state = FirebaseMusicDownloadState(
              isLoading: false,
              isCompleted: true,
              musicName: reference.name,
              alreadyExist: false,
            );
            ref.read(getAudioProvider.notifier).querySongs();
          }
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

  double calculatePercentage(int received, int total) {
    if (total == 0) {
      return 0;
    }
    return (received / total) * 100;
  }
}

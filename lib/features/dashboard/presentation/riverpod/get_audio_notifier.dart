part of './get_audio_provider.dart';

class GetAudioNotifier extends Notifier<GetAudioState> {
  @override
  GetAudioState build() {
    return GetAudioState();
  }

  Future<List<File>> getFilesFromAppSpecificFolder(String directoryPath) async {
    final files = <File>[];

    final directory = Directory(
      directoryPath,
    );

    if (directory.existsSync()) {
      final fileList = directory.listSync();

      for (final file in fileList) {
        if (file is File) {
          files.add(file);
        }
      }
    }

    return files;
  }

  Future<void> querySongs() async {
    state = GetAudioState(
      status: MusicStatus.loading,
    );

    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();

    final files = await getFilesFromAppSpecificFolder(
      '${directory?.path}/${AudioDirectories.music}',
    );

    for (var file = 0; file < files.length; file++) {
      if (files[file].path.endsWith('.mp3') ||
          files[file].path.endsWith('.wav') ||
          files[file].path.endsWith('.ogg') ||
          files[file].path.endsWith('.flac') ||
          files[file].path.endsWith('.m4a')) {
        final displayName = files[file].path.split('/').last;
        final alreadyExists = MusicModel.musicModelList
            .any((music) => music.displayName == displayName);

        if (!alreadyExists) {
          final music = MusicModel(
            id: file,
            uri: files[file].uri.toString(),
            displayName: displayName,
            displayNameWOExt: null,
          );
          MusicModel.musicModelList.add(music);
        }
      }
    }
    state = GetAudioState(
      status: MusicStatus.success,
      data: MusicModel.musicModelList,
    );
  }

  Future<void> querySongFromDropbox() async {
    state = GetAudioState(
      status: MusicStatus.loading,
    );

    final directory = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();

    final files = await getFilesFromAppSpecificFolder(
      '${directory?.path}/dropbox/download',
    );

    for (var file = 0; file < files.length; file++) {
      if (files[file].path.endsWith('.mp3') ||
          files[file].path.endsWith('.wav') ||
          files[file].path.endsWith('.ogg') ||
          files[file].path.endsWith('.flac') ||
          files[file].path.endsWith('.m4a')) {
        final displayName = files[file].path.split('/').last;
        final alreadyExists = MusicModel.musicModelList
            .any((music) => music.displayName == displayName);

        if (!alreadyExists) {
          final music = MusicModel(
            id: file,
            uri: files[file].uri.toString(),
            displayName: displayName,
            displayNameWOExt: null,
          );
          MusicModel.musicModelList.add(music);
        }
      }
    }
    state = GetAudioState(
      status: MusicStatus.success,
      data: MusicModel.musicModelList,
    );
  }
}

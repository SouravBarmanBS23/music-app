part of './audio_player_provider.dart';

class AudioPlayerNotifier extends Notifier<AudioPlayerStateTest> {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final storagePermission = Permission.storage;
  late final AnimationController animationController;

  @override
  AudioPlayerStateTest build() {
    return AudioPlayerStateTest(
      playIndex: 0,
      isPlaying: false,
    );
  }

  void isPlaying(int index, bool value) {
    if (value) {
      audioPlayer.play();
      state = AudioPlayerStateTest(
        playIndex: index,
        isPlaying: value,
      );
    } else {
      audioPlayer.pause();
      state = AudioPlayerStateTest(
        playIndex: index,
        isPlaying: value,
      );
    }
  }

  void updatePosition() {
    final duration = ref.read(durationProvider.notifier);
    final max = ref.read(maxProvider.notifier);

    audioPlayer.durationStream.listen((d) {
      duration.state = d.toString().split('.')[0];
      max.state = d!.inSeconds.toDouble();
    });

    audioPlayer.positionStream.listen((p) {
      final position = ref.read(positionProvider.notifier);
      final value = ref.read(valueProvider.notifier);
      position.state = p.toString().split('.')[0];
      value.state = p.inSeconds.toDouble();
    });
  }

  void changeDurationToSeconds(int seconds) {
    final duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void playSongs(String? uri, int index, dynamic songModel) {
    try {
      if (uri != null) {
        final uriData = Uri.parse(uri);
        audioPlayer
          ..setAudioSource(
            AudioSource.uri(
              uriData,
              tag: MediaItem(
                id: '${songModel.id}',
                //  album: '${songModel.album}',
                title: songModel.displayName,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerStateTest(playIndex: index, isPlaying: true);
        updatePosition();
      } else {}
    } catch (e) {
      Log.debug('Error while playing the audio: $e');
    }
  }

  Future<void> requestPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final permission =
        deviceInfo.version.sdkInt > 32 ? Permission.audio : Permission.storage;
    final permissionNotifier = ref.read(permissionGranted.notifier);

    if (await permission.status.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        permissionNotifier.state = 1;
      } else if (result.isDenied) {
        permissionNotifier.state = 0;
        await SystemNavigator.pop();
      } else if (result.isPermanentlyDenied) {
        await openAppSettings();
      }
    } else if (await permission.status.isGranted) {
      permissionNotifier.state = 1;
    }
  }

  Future<void> requestAudioAndStoragePermissions() async {
    final permissionNotifier = ref.read(permissionGranted.notifier);

    final audioPermissionStatus = await Permission.audio.status;
    final mediaLibraryWritePermissionStatus =
        await Permission.mediaLibrary.status;

    var shouldOpenSettings = false;

    if (audioPermissionStatus.isDenied || audioPermissionStatus.isRestricted) {
      final audioPermissionRequestResult = await Permission.audio.request();
      if (audioPermissionRequestResult.isGranted) {
      } else if (audioPermissionRequestResult.isPermanentlyDenied) {
        shouldOpenSettings = true;
      }
    }

    if (mediaLibraryWritePermissionStatus.isDenied ||
        mediaLibraryWritePermissionStatus.isRestricted) {
      final mediaLibraryWritePermissionRequestResult =
          await Permission.mediaLibrary.request();
      if (mediaLibraryWritePermissionRequestResult.isGranted) {
      } else if (mediaLibraryWritePermissionRequestResult.isPermanentlyDenied) {
        shouldOpenSettings = true;
      }
    }

    if (shouldOpenSettings) {
      await openAppSettings();
    }

    if (audioPermissionStatus.isGranted &&
        mediaLibraryWritePermissionStatus.isGranted) {
      // Permissions granted, proceed with audio and storage operations
      permissionNotifier.state = 1;
    } else {
      // Permissions not granted, handle accordingly
      permissionNotifier.state = 0;
      await openAppSettings();
    }
  }

  void playPrevious(String? uri, int index, dynamic songModel) {
    if (index == 0) {
      audioPlayer
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse(uri!),
            tag: MediaItem(
              id: '${songModel.id}',
              // album: '${songModel.album}',
              title: songModel.displayName,
              artUri: Uri.parse(
                'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
              ),
            ),
          ),
        )
        ..play();
      state = AudioPlayerStateTest(playIndex: index, isPlaying: true);
      updatePosition();
    } else {
      try {
        audioPlayer
          ..setAudioSource(
            AudioSource.uri(
              Uri.parse(uri!),
              tag: MediaItem(
                // Specify a unique ID for each media item:
                id: '${songModel.id}',
                // Metadata to display in the notification:
                // album: '${songModel.album}',
                title: songModel.displayName,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerStateTest(playIndex: index - 1, isPlaying: true);
        updatePosition();
      } catch (e) {
        Log.debug(e.toString());
      }
    }
  }

  void playForward(String? uri, int index, int limit, MusicModel songModel) {
    if (index == limit) {
      audioPlayer
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse(uri!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: '${songModel.id}',
              // Metadata to display in the notification:
              //  album: '${songModel.album}',
              title: songModel.displayName,
              artUri: Uri.parse(
                'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
              ),
            ),
          ),
        )
        ..play();
      state = AudioPlayerStateTest(playIndex: index, isPlaying: true);
      updatePosition();
    } else {
      try {
        audioPlayer
          ..setAudioSource(
            AudioSource.uri(
              Uri.parse(uri!),
              tag: MediaItem(
                // Specify a unique ID for each media item:
                id: '${songModel.id}',
                // Metadata to display in the notification:
                // album: '${songModel.album}',
                title: songModel.displayName,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerStateTest(playIndex: index + 1, isPlaying: true);
        updatePosition();
      } catch (e) {
        Log.debug(e.toString());
      }
    }
  }
}

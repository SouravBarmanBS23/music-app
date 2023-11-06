import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:music_app/core/constants/hive_db.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerNotifier extends Notifier<AudioPlayerState> {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final storagePermission = Permission.storage;
  late final AnimationController animationController;

  @override
  AudioPlayerState build() {
    return AudioPlayerState(
      playIndex: 0,
      isPlaying: false,
    );
  }

  Future<List<SongModel>> querySongs() async {
    return audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      // path: '/storage/emulated/0/Android/data/com.example.musicapp.music_app/files/data/user/0/com.example.musicapp.music_app/files/',
    );
  }

  void isPlaying(int index, bool value) {
    if (value) {
      audioPlayer.play();
      state = AudioPlayerState(
        playIndex: index,
        isPlaying: value,
      );
    } else {
      audioPlayer.pause();
      state = AudioPlayerState(
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

  void playSongs(String? uri, int index, SongModel songModel) {
    try {
      if (uri != null) {
        final uriData = Uri.parse(uri);
        audioPlayer
          ..setAudioSource(
            AudioSource.uri(
              uriData,
              tag: MediaItem(
                id: '${songModel.id}',
                album: '${songModel.album}',
                title: songModel.displayNameWOExt,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerState(playIndex: index, isPlaying: true);
        updatePosition();
      } else {}
    } catch (e) {
      Log.debug('Error while playing the audio: $e');
    }
  }

  Future<void> requestPermission() async {
    const permission = Permission.storage;
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

  void playPrevious(String? uri, int index, SongModel songModel) {
    if (index == 0) {
      audioPlayer
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse(uri!),
            tag: MediaItem(
              id: '${songModel.id}',
              album: '${songModel.album}',
              title: songModel.displayNameWOExt,
              artUri: Uri.parse(
                'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
              ),
            ),
          ),
        )
        ..play();
      state = AudioPlayerState(playIndex: index, isPlaying: true);
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
                album: '${songModel.album}',
                title: songModel.displayNameWOExt,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerState(playIndex: index - 1, isPlaying: true);
        updatePosition();
      } catch (e) {
        Log.debug(e.toString());
      }
    }
  }

  void playForward(String? uri, int index, int limit, SongModel songModel) {
    if (index == limit) {
      audioPlayer
        ..setAudioSource(
          AudioSource.uri(
            Uri.parse(uri!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: '${songModel.id}',
              // Metadata to display in the notification:
              album: '${songModel.album}',
              title: songModel.displayNameWOExt,
              artUri: Uri.parse(
                'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
              ),
            ),
          ),
        )
        ..play();
      state = AudioPlayerState(playIndex: index, isPlaying: true);
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
                album: '${songModel.album}',
                title: songModel.displayNameWOExt,
                artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg',
                ),
              ),
            ),
          )
          ..play();
        state = AudioPlayerState(playIndex: index + 1, isPlaying: true);
        updatePosition();
      } catch (e) {
        Log.debug(e.toString());
      }
    }
  }

  Future<void> scanAppFolder() async {
    var directoryPath = await HiveDB.retrieveDirectoryFromHive();
    final box = Hive.box<String>('cloud-download');
    directoryPath = directoryPath ??
        '/storage/emulated/0/Android/data/com.example.musicapp.music_app/files/data/user/0/com.example.musicapp.music_app/files/';

    print('Scanning to this directory');
    if (box.isNotEmpty) {
      await MediaScanner.loadMedia(path: directoryPath);
      final result = await getApplicationDocumentsDirectory();
      print('getApplicationDocumentsDirectory: ${result.path} ');
      // await audioQuery.scanMedia();
      // final file = File(directoryPath);
      // print(file);
      // try {
      await audioQuery.scanMedia(result.path); // Scan the media 'path'
      // } catch (e) {
      //   print('$e');
      // }

      // final files = await getFileNamesFromFolder(directoryPath);
      // for (var i = 0; i < files.length; i++) {
      //
      //   await audioQuery.scanMedia('$directoryPath${files[i]}');
      //   print('${i + 1}.$directoryPath${files[i]}}');
      // }
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

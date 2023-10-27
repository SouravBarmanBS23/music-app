import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerNotifier extends Notifier<AudioPlayerState> {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final storagePermission = Permission.storage;

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

  void changeDurationToSeconds(seconds) {
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
                // Specify a unique ID for each media item:
                id: '${songModel.id}',
                // Metadata to display in the notification:
                album: '${songModel.album}',
                title: songModel.displayNameWOExt,
                artUri: Uri.parse(
                    'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg'),
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
              // Specify a unique ID for each media item:
              id: '${songModel.id}',
              // Metadata to display in the notification:
              album: '${songModel.album}',
              title: songModel.displayNameWOExt,
              artUri: Uri.parse(
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg'),
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
                artUri: Uri.parse('https://example.com/albumart.jpg'),
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
                  'https://t3.ftcdn.net/jpg/03/01/43/92/360_F_301439209_vpF837oCGM1lp0cnC7stzCBn3th0dQ6O.jpg'),
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
                artUri: Uri.parse('https://example.com/albumart.jpg'),
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
}

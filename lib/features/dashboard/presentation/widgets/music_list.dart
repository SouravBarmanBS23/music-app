import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/pages/player_page.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/get_audio_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends ConsumerStatefulWidget {
  const MusicList({super.key});

  @override
  ConsumerState<MusicList> createState() => _MusicListState();
}

class _MusicListState extends ConsumerState<MusicList> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(getAudioProvider.notifier).querySongs();
      ref.read(getAudioProvider.notifier).querySongFromDropbox();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(audioPlayerProvider);
    final permissionStatus = ref.watch(permissionGranted);
    final getState = ref.watch(getAudioProvider);

    if (permissionStatus == 1) {
      if (getState.status == MusicStatus.loading) {
        return SizedBox(
          height: 0.65.sh,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (getState.status == MusicStatus.success &&
          MusicModel.musicModelList.isNotEmpty) {
        final songsList = getState.data as List<MusicModel>;
        return SizedBox(
          height: 0.65.sh,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: songsList.length,
            itemBuilder: (_, index) {
              final snapshot = songsList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white10,
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: bgColor,
                  leading: QueryArtworkWidget(
                    id: snapshot.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    snapshot.displayName,
                    maxLines: 1,
                    style: AppTextStyle.textStyleOne(
                      Colors.white,
                      20,
                      FontWeight.w300,
                    ),
                  ),
                  subtitle: Text(
                    Strings.unknownArtist,
                    maxLines: 1,
                    style: AppTextStyle.textStyleOne(
                      Colors.white,
                      15,
                      FontWeight.w300,
                    ),
                  ),
                  trailing: state.playIndex == index && state.isPlaying
                      ? const IconButton(
                          onPressed: HapticFeedback.mediumImpact,
                          icon: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerPage(
                          songModel: songsList,
                          songIndex: index,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      } else {
        return Center(
          child: Text(
            Strings.noMusicFound,
            style: AppTextStyle.textStyleOne(Colors.white, 22, FontWeight.w500),
          ),
        );
      }
    } else {
      return Center(
        child: Text(
          Strings.permissionFirst,
          style: AppTextStyle.textStyleOne(Colors.white, 22, FontWeight.w500),
        ),
      );
    }
  }
}

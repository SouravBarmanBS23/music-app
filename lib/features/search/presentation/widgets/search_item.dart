import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/pages/player_page.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/search/presentation/riverpod/music_search_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchItem extends ConsumerStatefulWidget {
  const SearchItem({super.key});

  @override
  ConsumerState<SearchItem> createState() => _MusicListState();
}

class _MusicListState extends ConsumerState<SearchItem> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(audioPlayerProvider);
    final musicSearchNotifier = ref.read(musicSearchProvider.notifier);
    final musicState = ref.watch(musicSearchProvider);

    if (musicState.isFound == 1) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        height: 0.65.sh,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: musicSearchNotifier.filteredSongs.length,
          itemBuilder: (_, index) {
            final song = musicSearchNotifier.filteredSongs[index];
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
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  song.displayNameWOExt,
                  maxLines: 1,
                  style: AppTextStyle.textStyleOne(
                    Colors.white,
                    20,
                    FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  song.artist ?? 'Unknown',
                  maxLines: 1,
                  style: AppTextStyle.textStyleOne(
                    Colors.white,
                    15,
                    FontWeight.w400,
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
                        songModel: musicSearchNotifier.filteredSongs,
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
    } else if (musicState.isFound == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset(
              'lottie-animation/show-search-animation.json',
              repeat: true,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'lottie-animation/no-music-found-two.json',
                repeat: true,
                height: 230,
                width: 270,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      );
    }
  }
}

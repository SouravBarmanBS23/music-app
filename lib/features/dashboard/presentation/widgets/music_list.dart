import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/pages/player_page.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends ConsumerStatefulWidget {
  const MusicList({super.key});

  @override
  ConsumerState<MusicList> createState() => _MusicListState();
}

class _MusicListState extends ConsumerState<MusicList> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(audioPlayerProvider.notifier);
    final state = ref.watch(audioPlayerProvider);
    final permissionStatus = ref.watch(permissionGranted);

    if (permissionStatus == 1) {
      return SizedBox(
        height: 0.65.sh,
        child: FutureBuilder<List<SongModel>>(
          future: notifier.querySongs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final songsList = snapshot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: songsList?.length ?? 0,
                itemBuilder: (_, index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white10, //const Color(0xff1c1f29),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: bgColor,
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].displayNameWOExt,
                        maxLines: 1,
                        style: AppTextStyle.textStyleOne(
                            Colors.white, 20, FontWeight.w300,),
                      ),
                      subtitle: Text(
                        snapshot.data![index].artist ?? 'Unknown',
                        maxLines: 1,
                        style: AppTextStyle.textStyleOne(
                            Colors.white, 15, FontWeight.w300,),
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
                        //  notifier.playSongs(snapshot.data![index].data,
                        //  index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerPage(
                              songModel: snapshot.data!,
                              songIndex: index,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text('No Data'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    } else {
      return Center(
        child: Text(
          'No Music Found',
          style: AppTextStyle.textStyleOne(Colors.white, 22, FontWeight.w500),
        ),
      );
    }
  }
}

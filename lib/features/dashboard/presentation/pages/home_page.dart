import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/pages/player_page.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/app_color.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initializeApp();
  }
  // Future<void> _initializeApp() async {
  //   final audioPlayerNotifier = ref.read(audioPlayerProvider.notifier);
  //   await audioPlayerNotifier.checkPermission().then((value) {
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(audioPlayerProvider.notifier);
    final state = ref.watch(audioPlayerProvider);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  'Music app',
                  style: AppTextStyle.textStyleOne(
                      Colors.white, 24, FontWeight.w500),
                ),
                const Icon(
                  Icons.queue_music_sharp,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: bgColor,
              height: 0.20.sh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.purple.shade200,
                      image: const DecorationImage(
                        image: AssetImage('images/music-1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 0.9.sw,
                    height: 0.2.sh,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(milliseconds: 1000),
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Let's play music",
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, top: 10, bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                'All songs ',
                style: AppTextStyle.textStyleOne(
                    Colors.white, 20, FontWeight.w600),
              ),
            ),
            ref.watch(permissionGranted) == 1
                ? Container(
                    height: 0.65.sh,
                    child: FutureBuilder<List<SongModel>>(
                      future: notifier.audioQuery.querySongs(
                        ignoreCase: true,
                        orderType: OrderType.ASC_OR_SMALLER,
                        sortType: null,
                        uriType: UriType.EXTERNAL,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          final songsList = snapshot.data;
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: songsList?.length ?? 0,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      Colors.white10, //const Color(0xff1c1f29),
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  tileColor: false ? Colors.white : bgColor,
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
                                        Colors.white, 20, FontWeight.w300),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].artist ?? 'Unknown',
                                    maxLines: 1,
                                    style: AppTextStyle.textStyleOne(
                                        Colors.white, 15, FontWeight.w300),
                                  ),
                                  trailing: state.playIndex == index &&
                                          state.isPlaying
                                      ? IconButton(
                                          onPressed: () {
                                            HapticFeedback.mediumImpact();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                  onTap: () {
                                    //  notifier.playSongs(snapshot.data![index].data, index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlayerPage(
                                              songModel: snapshot.data!,
                                              songIndex: index)),
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
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

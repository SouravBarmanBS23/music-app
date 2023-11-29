import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';

class PlayerPage extends ConsumerStatefulWidget {
  const PlayerPage({
    required this.songModel,
    required this.songIndex,
    super.key,
  });

  final List<dynamic> songModel;
  final int songIndex;

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends ConsumerState<PlayerPage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(audioPlayerProvider.notifier).playSongs(
            widget.songModel[widget.songIndex].uri,
            widget.songIndex,
            widget.songModel[widget.songIndex],
          );
    });

    animationController = AnimationController(vsync: this);
    // lottieControllerStream();
  }

  void lottieControllerStream() {
    final notifier = ref.read(audioPlayerProvider.notifier);

    notifier.audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        animationController
          ..duration = const Duration(seconds: 3)
          ..repeat();
      } else {
        animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(audioPlayerProvider.notifier);
    final state = ref.watch(audioPlayerProvider);

    final duration = ref.watch(durationProvider);
    final position = ref.watch(positionProvider);
    final value = ref.watch(valueProvider);
    final max = ref.watch(maxProvider);

    return Scaffold(
      backgroundColor: findMusicBody, // Color(0xff907cbe),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 0.04.sh,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First section
            Container(
              width: double.infinity,
              height: 0.54.sh,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Colors.black,
              ),
              child: Lottie.asset(
                'lottie-animation/music-animation-2.json',
                repeat: true,
                fit: BoxFit.cover,
                controller: animationController,
                onLoaded: (composition) {
                  animationController
                    ..duration = composition.duration
                    ..repeat();
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 0.38.sh,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20.h),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    width: double.infinity,
                    child: Text(
                      widget.songModel[state.playIndex].displayName,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.textStyleOne(
                        Colors.white,
                        22,
                        FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top: 5.h),
                    width: double.infinity,
                    child: Text(
                      Strings.unknownArtist,
                      maxLines: 1,
                      style: AppTextStyle.textStyleOne(
                        Colors.white,
                        16,
                        FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15.h,
                      bottom: 15.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          position,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            min:
                                const Duration(seconds: 0).inSeconds.toDouble(),
                            max: max,
                            value: value,
                            onChanged: (value) {
                              notifier.changeDurationToSeconds(value.toInt());
                              value = value;
                            },
                          ),
                        ),
                        Text(
                          duration,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Previous Button
                        IconButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            notifier.playPrevious(
                              widget
                                  .songModel[state.playIndex == 0
                                      ? 0
                                      : state.playIndex - 1]
                                  .uri,
                              state.playIndex,
                              widget.songModel[state.playIndex == 0
                                  ? 0
                                  : state.playIndex - 1],
                            );
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            if (notifier.audioPlayer.playing == true) {
                              notifier.isPlaying(
                                state.playIndex,
                                value: false,
                              );
                              animationController.stop();
                            } else {
                              notifier.isPlaying(
                                state.playIndex,
                                value: true,
                              );
                              animationController.repeat();
                            }
                          },
                          icon: notifier.audioPlayer.playing == true
                              ? const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                        ),

                        // Forward Button
                        IconButton(
                          onPressed: () {
                            HapticFeedback.mediumImpact();

                            if (widget.songModel.length <=
                                state.playIndex + 1) {
                            } else {
                              notifier.playForward(
                                widget.songModel[state.playIndex + 1].uri,
                                state.playIndex,
                                widget.songModel.length,
                                widget.songModel[state.playIndex + 1],
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

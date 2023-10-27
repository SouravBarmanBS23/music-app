import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/audio_player_provider.dart';
import 'package:music_app/features/dashboard/presentation/widgets/music_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(audioPlayerProvider.notifier).requestPermission();
  }

  @override
  Widget build(BuildContext context) {
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
                  Icons.queue_music_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  'Music app',
                  style: AppTextStyle.textStyleOne(
                      Colors.white, 24, FontWeight.w500,),
                ),
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
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
                      borderRadius: BorderRadius.circular(20),
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
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Let's play music",
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        onTap: () {
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
                    Colors.white, 20, FontWeight.w600,),
              ),
            ),
            const MusicList(),
          ],
        ),
      ),
    );
  }
}

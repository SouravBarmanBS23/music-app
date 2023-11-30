import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:core/core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/firebase_music/presentation/riverpod/firebase_auth_provider.dart';
import 'package:music_app/features/firebase_music/presentation/riverpod/firebase_music_download_provider.dart';

class FirebaseMusicPage extends ConsumerStatefulWidget {
  const FirebaseMusicPage({super.key});

  @override
  ConsumerState<FirebaseMusicPage> createState() => _FirebaseMusicPageState();
}

class _FirebaseMusicPageState extends ConsumerState<FirebaseMusicPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(firebaseMusicDownloadProvider.notifier);
    final firebaseAuthNotifier = ref.read(firebaseAuthProvider.notifier);
    final firebaseBox =
        ref.read(cloudDownloadCacheServiceProvider(firebaseHiveBoxName));

    ref
      ..listen(firebaseMusicDownloadProvider, (previous, next) {
        if ((next.isCompleted == true) &&
            (next.alreadyExist == false) &&
            (next.isLoading == false)) {
          ShowSnackBar.showSnackBar(
            context,
            'Download Completed',
            next.musicName,
          );
        }
        if ((next.isCompleted == false) && (next.alreadyExist == true)) {
          ShowSnackBar.showSnackBar(
            context,
            'Already Downloaded',
            next.musicName,
          );
        }
      })
      ..listen(firebaseAuthProvider, (previous, next) {
        if (next.isSignout == true) {
          Navigator.pop(context);
        }
      });

    return Scaffold(
      backgroundColor: const Color(0xff350c44),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          HapticFeedback.mediumImpact();
          firebaseAuthNotifier.handleSignOut();
        },
        child: const Icon(Icons.logout_outlined),
      ),
      appBar: AppBar(
        toolbarHeight: 0.04.sh,
        backgroundColor: const Color(0xff350c44),
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
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/wallpapers/pic-6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0.05.sh),
                height: 0.20.sh,
                width: double.infinity,
                child: FittedBox(
                  child: Lottie.asset(
                    'lottie-animation/cloud-animation.json',
                    repeat: true,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 0.01.sh, left: 0.07.sw),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Latest Musics',
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 0.6.sh,
                width: double.infinity,
                child: FutureBuilder<ListResult>(
                  future: notifier.futureFiles,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final files = snapshot.data!.items;
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: files.length,
                        itemBuilder: (_, index) {
                          final file = files[index];
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white10,
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tileColor: bgColor,
                              leading: const Icon(
                                Icons.music_note,
                                size: 30,
                                color: Colors.white,
                              ),
                              title: Text(
                                file.name,
                                maxLines: 1,
                                style: AppTextStyle.textStyleOne(
                                  Colors.white,
                                  20,
                                  FontWeight.w400,
                                ),
                              ),
                              trailing: firebaseBox.isContain(
                                file.name,
                              )
                                  ? IconButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        ShowSnackBar.alreadyDownloadedSnackBar(
                                          context,
                                          Strings.alreadyDownloaded,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.cloud_done_outlined,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        HapticFeedback.mediumImpact();
                                        notifier.downloadFile(file, index);
                                      },
                                      icon: const Icon(
                                        Icons.download,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

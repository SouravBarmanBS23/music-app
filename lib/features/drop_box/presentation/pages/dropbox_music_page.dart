import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/dashboard/presentation/riverpod/get_audio_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/background_image_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_download_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_fetch_notifier.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_fetch_provider.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/user_info_provider.dart';

part '../widgets/pull_to_refresh.dart';
part '../widgets/dropbox_music_list.dart';

class DropBoxMusicPage extends ConsumerStatefulWidget {
  const DropBoxMusicPage({super.key});

  @override
  ConsumerState<DropBoxMusicPage> createState() => _DropBoxMusicPageState();
}

class _DropBoxMusicPageState extends ConsumerState<DropBoxMusicPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(dropboxMusicFetchProvider.notifier).initDropbox();
      ref.read(dropboxMusicFetchProvider.notifier).checkAuthorized(
            authorize: true,
          );
      ref.read(dropBoxMusicDownloadProvider.notifier).getCachedMusicName();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dropBoxAuthState = ref.watch(dropboxMusicFetchProvider);
    final dropBoxFetchNotifier = ref.read(dropboxMusicFetchProvider.notifier);
    final audioQueryNotifier = ref.read(getAudioProvider.notifier);
    final imageState = ref.watch(backgroundProvider);
    final imageNotifier = ref.read(backgroundProvider.notifier);
    final userInfoState = ref.watch(userInfoProvider);
    final userInfoNotifier = ref.read(userInfoProvider.notifier);
    final dropboxDownloadNotifier =
        ref.read(dropBoxMusicDownloadProvider.notifier);

    ref
      ..listen(dropboxMusicFetchProvider, (previous, next) async {
        if (next == DropboxAuthState.loading) {
        } else {
          await userInfoNotifier.getAccountInfo();
        }
      })
      ..listen(dropBoxMusicDownloadProvider, (previous, next) {
        if (next == DownloadState.loading) {
          ShowSnackBar.showSnackBar(
            context,
            'from DropBox...',
            'Start Downloading',
          );
        }
        if (next == DownloadState.success) {
          audioQueryNotifier.querySongFromDropbox();
          dropboxDownloadNotifier.getCachedMusicName();
        }
      });

    return Scaffold(
      backgroundColor: const Color(0xff350c44),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          dropBoxFetchNotifier.dropboxLogout();
          Navigator.pop(context);
        },
        child: const Icon(Icons.logout_outlined),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${Images.dropbox}${imageState + 1}.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (dropBoxAuthState == DropboxAuthState.loading)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            )
          else
            RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(milliseconds: 500),
                    () async {
                  await HapticFeedback.mediumImpact();
                  await ref
                      .read(dropboxMusicFetchProvider.notifier)
                      .listFolder('');
                });
              },
              child: ListView(
                children: [
                  SizedBox(
                    height: 0.07.sh,
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (userInfoState == UserState.loading)
                                  const CircularProgressIndicator()
                                else
                                  Text(
                                    userInfoNotifier.userModel.isNotEmpty
                                        ? userInfoNotifier
                                            .userModel[0].displayName
                                            .toString()
                                        : 'empty',
                                    maxLines: 1,
                                    style: AppTextStyle.textStyleOne(
                                      Colors.white,
                                      14,
                                      FontWeight.w400,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ClipOval(
                                  child: Container(
                                    height: 0.04.sh,
                                    width: 0.04.sh,
                                    color: Colors.white24,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 0.09.sh,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.featured,
                          maxLines: 1,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            28,
                            FontWeight.w600,
                          ),
                        ),
                        Text(
                          Strings.downloadedSongs,
                          maxLines: 1,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            22,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.35.sh,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            imageNotifier.setBackgroundImage(index);
                          },
                          child: Container(
                            width: 170.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(5, 5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                '${Images.dropbox}${index + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 0.04.sh,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'For',
                          maxLines: 1,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            28,
                            FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'You',
                          maxLines: 1,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            28,
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 0.4.sh,
                    width: double.infinity,
                    child: dropBoxFetchNotifier.musicList.isEmpty
                        ? const PullToRefresh()
                        : const DropboxMusicList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

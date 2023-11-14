import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';

import 'package:music_app/features/drop_box/presentation/riverpod/background_image_provider.dart';

import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_auth_provider.dart';

import '../riverpod/dropbox_music_fetch_provider.dart';
import '../riverpod/user_info_provider.dart';

class DropBoxMusicPage extends ConsumerStatefulWidget {
  const DropBoxMusicPage({super.key});

  @override
  ConsumerState<DropBoxMusicPage> createState() => _DropBoxMusicPageState();
}

class _DropBoxMusicPageState extends ConsumerState<DropBoxMusicPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future(() {
  //     ref.read(userInfoProvider.notifier).getAccountInfo();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final imageState = ref.watch(backgroundProvider);
    final imageNotifier = ref.read(backgroundProvider.notifier);
  //  final musicFetchNotifier = ref.read(dropboxMusicFetchProvider.notifier);
    final userInfoState = ref.watch(userInfoProvider);
    final userInfoNotifier = ref.read(userInfoProvider.notifier);

    return Scaffold(
      //  backgroundColor: const Color(0xff350c44),
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
          ListView(
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
                                    ? userInfoNotifier.userModel[0].email
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
                      'Featured',
                      maxLines: 1,
                      style: AppTextStyle.textStyleOne(
                        Colors.white,
                        28,
                        FontWeight.w600,
                      ),
                    ),
                    Text(
                      'DropBox Music',
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
              Container(
                // margin: EdgeInsets.only(top: 0.014.sh),
                height: 0.35.sh,
                width: double.infinity,
                // color: Colors.greenAccent,
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
                //  color: Colors.white,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    //  final file = files[index];
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white10, //const Color(0xff1c1f29),
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
                          'File name - $index',
                          maxLines: 1,
                          style: AppTextStyle.textStyleOne(
                            Colors.white,
                            20,
                            FontWeight.w400,
                          ),
                        ),
                        trailing: const IconButton(
                          onPressed: HapticFeedback.mediumImpact,
                          icon: Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    );
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

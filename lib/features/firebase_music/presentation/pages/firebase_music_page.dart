import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';

class FirebaseMusicPage extends StatefulWidget {
  const FirebaseMusicPage({super.key});

  @override
  State<FirebaseMusicPage> createState() => _FirebaseMusicPageState();
}

class _FirebaseMusicPageState extends State<FirebaseMusicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff350c44),
      appBar: AppBar(
        toolbarHeight: 0.04.sh,
        backgroundColor: Colors.transparent,
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
          SingleChildScrollView(
            child: Column(
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
                  //  color: Colors.white,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
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
                            'Music Name',
                            maxLines: 1,
                            style: AppTextStyle.textStyleOne(
                              Colors.white,
                              20,
                              FontWeight.w400,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

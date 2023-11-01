import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/firebase_music/presentation/pages/firebase_music_page.dart';

class CloudDownloadPage extends StatefulWidget {
  const CloudDownloadPage({super.key});

  @override
  State<CloudDownloadPage> createState() => _CloudDownloadPageState();
}

class _CloudDownloadPageState extends State<CloudDownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071d35),
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
                image: AssetImage('images/wallpapers/pic-8.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0.1.sh),
                  height: 0.20.sh,
                  width: double.infinity,
                  child: FittedBox(
                    child: Lottie.asset(
                      'lottie-animation/hello-anime.json',
                      repeat: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.02.sh),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Hello! Welcome to Our App',
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.01.sh, bottom: 0.04.sh),
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    child: Text(
                      'Download Music from Cloud',
                    ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 0.05.sh),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        width: 0.6.sw,
                        decoration: BoxDecoration(
                          color: const Color(0xffa37c75),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Dropbox',
                              style: AppTextStyle.textStyleOne(
                                  Colors.white, 20, FontWeight.w700),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'images/cloud/dropbox.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 0.02.sh),
                        height: 60,
                        width: 0.6.sw,
                        decoration: BoxDecoration(
                          color: const Color(0xffa37c75),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'iCloud',
                              style: AppTextStyle.textStyleOne(
                                  Colors.white, 20, FontWeight.w700),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'images/cloud/icloud.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 0.02.sh),
                        height: 60,
                        width: 0.6.sw,
                        decoration: BoxDecoration(
                          color: const Color(0xffa37c75),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Drive',
                              style: AppTextStyle.textStyleOne(
                                Colors.white,
                                20,
                                FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'images/cloud/google-drive-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 0.10.sh),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'Or you can download music from our platform. \n',
                        ),
                        TextSpan(
                          text: 'Click here',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xfff9d3a2),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              HapticFeedback.mediumImpact();
                              HapticFeedback.mediumImpact();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FirebaseMusicPage(),
                                ),
                              );
                            },
                        ), // Color(0xfff9d3a2)
                      ],
                    ),
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

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_form_field/input_form_field.dart';
import 'package:music_app/core/constants/app_color.dart';
import 'package:music_app/core/constants/text_style.dart';
import 'package:music_app/features/search/presentation/riverpod/music_search_provider.dart';
import 'package:music_app/features/search/presentation/widgets/search_item.dart';

class MusicSearch extends ConsumerStatefulWidget {
  const MusicSearch({super.key});

  @override
  ConsumerState<MusicSearch> createState() => _MusicSearchState();
}

class _MusicSearchState extends ConsumerState<MusicSearch> {
  final searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(musicSearchProvider.notifier).getSongs();
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(musicSearchProvider.notifier);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text(
            Strings.findYourMusic,
            style: AppTextStyle.textStyleOne(
              Colors.white,
              20,
              FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              HapticFeedback.mediumImpact();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: 22,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: bgColor,
                height: 0.20.sh,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: double.infinity,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Immerse in symphonies of sound.'),
                            FadeAnimatedText('Tune in anytime, anywhere.'),
                            FadeAnimatedText(
                              'Music speaks the language of the soul.',
                            ),
                            FadeAnimatedText(
                              'Every beat, every note, in your hand.',
                            ),
                            FadeAnimatedText('Let music move you.'),
                            FadeAnimatedText('Your groove, your playlists.'),
                            FadeAnimatedText('Classic hits to fresh releases.'),
                            FadeAnimatedText('Feel the rhythm, lose yourself.'),
                            FadeAnimatedText('Daily musical inspiration.'),
                            FadeAnimatedText('Music, part of your daily life.'),
                            FadeAnimatedText('Unlock the world of music.'),
                            FadeAnimatedText(
                              'Your musical journey starts here.',
                            ),
                            FadeAnimatedText('Create your musical story.'),
                            FadeAnimatedText('Dance to your playlist.'),
                            FadeAnimatedText('Share your music passions.'),
                          ],
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputFormField(
                        onChanged: (value) {
                          notifier.filterSongs(
                            value.toString(),
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        fillColor: const Color(0xfff6f7fb),
                        textEditingController: searchController,
                        validator: Validators.isValidPassword,
                        hintTextStyle: AppTextStyle.textStyleOne(
                          const Color(0xffC4C5C4),
                          15.sp,
                          FontWeight.w500,
                        ),
                        hintText: Strings.musicSearchHintText,
                        borderType: BorderType.none,
                        prefix: InkWell(
                          onTap: () {
                            notifier.filterSongs(
                              searchController.text,
                            );
                          },
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                            size: 25,
                            weight: 10,
                          ),
                        ),
                        errorTextStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.70.sh,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: bgColor,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const SearchItem(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

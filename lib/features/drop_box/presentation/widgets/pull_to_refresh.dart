part of '../pages/dropbox_music_page.dart';

class PullToRefresh extends StatelessWidget {
  const PullToRefresh({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10),
          height: 35.h,
          width: 160.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white12,
          ),
          child: Text(
            Strings.pullToRefresh,
            maxLines: 1,
            style: AppTextStyle.textStyleOne(
              Colors.white,
              18,
              FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

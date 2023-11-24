import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundImageNotifier extends StateNotifier<int> {
  BackgroundImageNotifier() : super(1);

  void setBackgroundImage(int index) {
    state = index;
  }
}

final backgroundProvider = StateNotifierProvider<BackgroundImageNotifier, int>(
  (ref) => BackgroundImageNotifier(),
);

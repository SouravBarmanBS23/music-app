import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadProgressNotifier extends StateNotifier<double> {
  DownloadProgressNotifier() : super(0);

  void updateProgress(double progress) {
    state = progress;
  }
}

final downloadProgressProvider =
    StateNotifierProvider<DownloadProgressNotifier, double>((ref) {
  final notifier = DownloadProgressNotifier();

  final cleanup = notifier.addListener((state) => debugPrint('$state'));
  ref.onDispose(cleanup);
  return notifier;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'global_state.dart';

class GlobalNotifier extends Notifier<GlobalState> {
  GlobalNotifier() : super();

  @override
  GlobalState build() {
    state = GlobalState();
    return state;
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleLogin() {
    state = state.copyWith(isLoggedIn: !state.isLoggedIn);
  }

  void toggleSubscription() {
    state = state.copyWith(isSubscribed: !state.isSubscribed);
  }

  void refresh() {
    state = state.copyWith(shouldRefresh: !state.shouldRefresh);
  }
}

final globalProvider =
    NotifierProvider<GlobalNotifier, GlobalState>(GlobalNotifier.new);

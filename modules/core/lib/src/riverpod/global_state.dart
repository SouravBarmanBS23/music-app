part of 'global_state_provider.dart';

class GlobalState {
  GlobalState({
    this.isDarkMode = false,
    this.isLoggedIn = false,
    this.isSubscribed = false,
    this.shouldRefresh = false,
  });

  final bool isDarkMode;
  final bool isLoggedIn;
  final bool isSubscribed;
  final bool shouldRefresh;

  GlobalState copyWith({
    bool? isDarkMode,
    bool? isLoggedIn,
    bool? isSubscribed,
    bool? shouldRefresh,
  }) {
    return GlobalState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      shouldRefresh: shouldRefresh ?? this.shouldRefresh,
    );
  }
}

import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:music_app/features/drop_box/data/model/user_model.dart';

enum UserState { initial, loading, success, error }

final userInfoProvider = NotifierProvider<UserInfoProvider, UserState>(
  UserInfoProvider.new,
);

class UserInfoProvider extends Notifier<UserState> {
  late final List<UserModel> userModel = [];

  @override
  UserState build() {
    return UserState.initial;
  }

  Future getAccountInfo() async {
    userModel.clear();
    state = UserState.loading;
    final accountInfo = await Dropbox.getCurrentAccount();
    if (accountInfo != null) {
      final getDataModel = UserModel(
        displayName: accountInfo.name!.displayName,
        email: accountInfo.email,
        homeNamespaceId: accountInfo.rootInfo!.homeNamespaceId,
        country: accountInfo.country,
      );
      userModel.add(getDataModel);
      state = UserState.success;
    } else {
      state = UserState.error;
    }
  }
}

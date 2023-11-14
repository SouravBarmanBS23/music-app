
import 'package:core/core.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:music_app/features/drop_box/data/model/user_model.dart';


class DropBoxMusicFetchNotifier extends Notifier<BaseState>{

  late final List<UserModel> userModel = [];

  @override
  BaseState build() {
    return BaseState.initial();
  }

  Future getAccountInfo() async {
    print('getAccountInfo');
    final accountInfo = await Dropbox.getCurrentAccount();

    if (accountInfo != null) {

     final getDataModel = UserModel(displayName: accountInfo.name!.displayName,
          email: accountInfo.email,
          homeNamespaceId: accountInfo.rootInfo!.homeNamespaceId,
          country: accountInfo.country,);
          userModel.add(getDataModel);

      print(accountInfo.name!.displayName);
      print(accountInfo.email);
      print(accountInfo.rootInfo!.homeNamespaceId);
      print(accountInfo.country);
    }
  }


}

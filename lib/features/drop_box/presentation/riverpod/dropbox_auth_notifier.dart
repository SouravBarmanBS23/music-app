import 'package:core/core.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/presentation/riverpod/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { initial, authenticated, unauthenticated, loading, error }

class DropBoxAuthNotifier extends Notifier<AuthState> {
  String? accessToken;
  String? credentials;
  bool showInstruction = false;

  @override
  AuthState build() {
    return AuthState.initial;
  }

  Future initDropbox() async {
    if (dropbox_key == 'dropbox_key') {
      showInstruction = true;
      return;
    }

    await Dropbox.init(dropbox_clientId, dropbox_key, dropbox_secret);
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('dropboxAccessToken');
    credentials = prefs.getString('dropboxCredentials');
  }

  Future<bool> checkAuthorized(bool authorize) async {
    state = AuthState.loading;

    final _credentials = await Dropbox.getCredentials();
    if (_credentials != null) {
      if (credentials == null || _credentials.isEmpty) {
        credentials = _credentials;
        await ref.read(userInfoProvider.notifier).getAccountInfo();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dropboxCredentials', credentials!);
      }
      state = AuthState.authenticated;
      return true;
    }

    final token = await Dropbox.getAccessToken();
    if (token != null) {
      if (accessToken == null || accessToken!.isEmpty) {
        accessToken = token;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dropboxAccessToken', accessToken!);
      }
      return true;
    }

    if (authorize) {
      if (credentials != null && credentials!.isNotEmpty) {
        await Dropbox.authorizeWithCredentials(credentials!);
        final _credentials = await Dropbox.getCredentials();
        if (_credentials != null) {
          state = AuthState.authenticated;
          return true;
        }
      }
      if (accessToken != null && accessToken!.isNotEmpty) {
        await Dropbox.authorizeWithAccessToken(accessToken!);
        final token = await Dropbox.getAccessToken();
        if (token != null) {
          return true;
        }
      } else {
        await Dropbox.authorize();
      }
    }
    state = AuthState.unauthenticated;
    return false;
  }

  Future authorize() async {
    await Dropbox.authorize();
  }

  Future unlinkToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dropboxAccessToken');
    accessToken = null;
    await Dropbox.unlink();
  }

  Future unlinkCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dropboxCredentials');
    credentials = null;
    await Dropbox.unlink();
  }

  Future getAccountName() async {
    if (await checkAuthorized(true)) {
      // final user = await Dropbox.getAccountName();
    }
  }
}

import 'dart:io';
import 'dart:math';

import 'package:core/core.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/features/drop_box/data/model/dropbox_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:music_app/features/drop_box/presentation/riverpod/dropbox_music_fetch_provider.dart';


enum DropboxAuthState { initial, authenticated, unauthenticated, loading, error }

class DropBoxMusicFetchNotifier extends Notifier<DropboxAuthState>{
  final list = List<dynamic>.empty(growable: true);
  String? accessToken;
  String? credentials;
  bool showInstruction = false;
  final List<DropboxFile> musicList = [];

  @override
  DropboxAuthState build() {

    return DropboxAuthState.initial;
  }

  Future initDropbox() async {
    if (dropbox_key == 'dropbox_key') {
      showInstruction = true;
      return;
    }
    state = DropboxAuthState.loading;
    await Dropbox.init(dropbox_clientId, dropbox_key, dropbox_secret);

    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('dropboxAccessToken');
    credentials = prefs.getString('dropboxCredentials');
    state = DropboxAuthState.initial;
  }

  Future<bool> checkAuthorized(bool authorize) async {

    state = DropboxAuthState.loading;

    final _credentials = await Dropbox.getCredentials();
    if (_credentials != null) {
      if (credentials == null || _credentials.isEmpty) {
        credentials = _credentials;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dropboxCredentials', credentials!);
      }
      state = DropboxAuthState.authenticated;
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
          print('authorizeWithCredentials!');
          return true;
        }
      }
      if (accessToken != null && accessToken!.isNotEmpty) {
        await Dropbox.authorizeWithAccessToken(accessToken!);
        final token = await Dropbox.getAccessToken();
        if (token != null) {
          print('authorizeWithAccessToken!');
          state = DropboxAuthState.authenticated;
          return true;
        }
      } else {
        await Dropbox.authorize();
        print('authorize!');
      }
    }
    return false;
  }



  Future authorize() async {
    await Dropbox.authorize();
  }

  Future authorizePKCE() async {
    await Dropbox.authorizePKCE();
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

  Future dropboxLogout()async{

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dropboxAccessToken');
    await prefs.remove('dropboxCredentials');
    accessToken = null;
    credentials = null;
    await Dropbox.unlink();

  }




  Future authorizeWithAccessToken() async {
    await Dropbox.authorizeWithAccessToken(accessToken!);
  }

  Future authorizeWithCredentials() async {
    await Dropbox.authorizeWithCredentials(credentials!);
  }

  Future getAccountName() async {
    if (await checkAuthorized(true)) {
      final user = await Dropbox.getAccountName();
      print('user = $user');
    }
  }

  Future listFolder(String path) async {
    if (await checkAuthorized(true)) {
      final List<dynamic> result = await Dropbox.listFolder(path);
      musicList.clear();
      Future.delayed(const Duration(seconds: 1), () {});

      for (final item in result) {
        try {
          final String name = item['name'] ?? '';
          if (isAudioFile(name)) {
            final dropboxItem = DropboxFile(
              pathDisplay: item['pathDisplay'] ?? '',
              name: name, isDownloaded: false,
            );
            musicList.add(dropboxItem);
          }
        } catch (e) {
          print('Error creating DropboxFile: $e');
        }
      }
        ref.refresh(dropboxMusicFetchProvider);
      print('dropboxItemList length : ${musicList.length}');
    }
  }

  Future uploadTest() async {
    if (await checkAuthorized(true)) {
      final tempDir = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      final filepath = '${tempDir?.path}/dropbox/test_upload.txt';
      File(filepath).writeAsStringSync(
        'contents.. from ${Platform.isIOS ? 'iOS' : 'Android'}\n',);

      final result =
      await Dropbox.upload(filepath, '/test_upload.txt', (uploaded, total) {
        print('progress $uploaded / $total');
      });
      print(result);
    }
  }

  Future downloadTest() async {
    if (await checkAuthorized(true)) {
      final tempDir = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      final filepath = '${tempDir?.path}/dropbox/download/test_download.txt';
      print(filepath);

      final result = await Dropbox.download('/test_upload.txt', filepath,
              (downloaded, total) {
            print('progress $downloaded / $total');
          });

      print(result);
      print(File(filepath).statSync());
    }
  }

  Future<String?> getTemporaryLink(String path) async {
    final result = await Dropbox.getTemporaryLink(path);
    return result;
  }


  Future getAccountInfo() async {
    final accountInfo = await Dropbox.getCurrentAccount();

    if (accountInfo != null) {
      print(accountInfo.name!.displayName);
      print(accountInfo.email);
      print(accountInfo.rootInfo!.homeNamespaceId);
      print(accountInfo.country);
    }
  }


  bool isAudioFile(String fileName) {
    final lowerCaseName = fileName.toLowerCase();
    return lowerCaseName.endsWith('.mp3') ||
        lowerCaseName.endsWith('.m4a') ||
        lowerCaseName.endsWith('.wav') ||
        lowerCaseName.endsWith('.flac') ||
        lowerCaseName.endsWith('.wma') ||
        lowerCaseName.endsWith('.aac');
  }



  void updateDownloadStatus(int index) {
    musicList[index] = musicList[index].copyWith(
          isDownloaded: !musicList[index].isDownloaded,
        );
    ref.refresh(dropboxMusicFetchProvider);
  }




}
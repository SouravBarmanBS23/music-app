import 'dart:convert';
import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String dropbox_clientId = 'g68550v5n79bccz';
const String dropbox_key = 'g68550v5n79bccz';
const String dropbox_secret = 'pgbxgtsnzhge60c';

class DropBoxHome extends StatefulWidget {
  const DropBoxHome({super.key});

  @override
  State<DropBoxHome> createState() => _DropBoxHomeState();
}

class _DropBoxHomeState extends State<DropBoxHome> {
  String? accessToken;
  String? credentials;
  bool showInstruction = false;

  @override
  void initState() {
    super.initState();

    initDropbox();
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

    setState(() {});
  }

  Future<bool> checkAuthorized(bool authorize) async {
    final _credentials = await Dropbox.getCredentials();
    if (_credentials != null) {
      if (credentials == null || _credentials!.isEmpty) {
        credentials = _credentials;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dropboxCredentials', credentials!);
      }
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

    setState(() {
      accessToken = null;
    });
    await Dropbox.unlink();
  }

  Future unlinkCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dropboxCredentials');

    setState(() {
      credentials = null;
    });
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

  Future listFolder(path) async {
    if (await checkAuthorized(true)) {
      final result = await Dropbox.listFolder(path);
      setState(() {
        list..clear()
        ..addAll(result);
      });
    }
  }

  Future uploadTest() async {
    if (await checkAuthorized(true)) {
      final tempDir = await getExternalStorageDirectory();
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
      final tempDir = await getExternalStorageDirectory();
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

  Future<String?> getTemporaryLink(path) async {
    final result = await Dropbox.getTemporaryLink(path);
    return result;
  }

  Uint8List? thumbImage;

  Future getThumbnail(path) async {
    final b64 = await Dropbox.getThumbnailBase64String(path);

    setState(() {
      thumbImage = base64Decode(b64!);
    });
  }

  Future getAccountInfo() async {
    final accountInfo = await Dropbox.getCurrentAccount();

    if (accountInfo != null) {
      print(accountInfo.name!.displayName);
      print(accountInfo.email!);
      print(accountInfo.rootInfo!.homeNamespaceId!);
      print(accountInfo.country!);
    }
  }

  final list = List<dynamic>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropbox example app'),
      ),
      body: showInstruction
          ? const Instructions()
          : Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: authorize,
                          child: const Text('authorize'),
                        ),
                        ElevatedButton(
                          onPressed: accessToken == null
                              ? null
                              : authorizeWithAccessToken,
                          child: const Text('authorizeWithAccessToken'),
                        ),
                        ElevatedButton(
                          onPressed: unlinkToken,
                          child: const Text('unlink'),
                        ),
                      ],
                    ),
                    Wrap(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: authorizePKCE,
                          child: const Text('authorizePKCE'),
                        ),
                        ElevatedButton(
                          onPressed: credentials == null
                              ? null
                              : authorizeWithCredentials,
                          child: const Text('authorizeWithCredentials'),
                        ),
                        ElevatedButton(
                          onPressed: unlinkCredentials,
                          child: const Text('unlink'),
                        ),
                      ],
                    ),
                    Wrap(
                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('list root folder'),
                          onPressed: () async {
                            await listFolder('');
                          },
                        ),
                        ElevatedButton(
                          child: const Text('test upload'),
                          onPressed: () async {
                            await uploadTest();
                          },
                        ),
                        ElevatedButton(
                          child: const Text('test download'),
                          onPressed: () async {
                            await downloadTest();
                          },
                        ),
                        ElevatedButton(
                          child: const Text('test thumbnail'),
                          onPressed: () async {
                            // await getThumbnail('/icon64.png');
                            await getThumbnail('/Get Started with Dropbox.pdf');
                          },
                        ),
                        if (thumbImage != null) Image.memory(thumbImage!),
                        ElevatedButton(
                          child: const Text('getAccountInfo'),
                          onPressed: () async {
                            await getAccountInfo();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          final filesize = item['filesize'];
                          final path = item['pathLower'];
                          bool isFile = false;
                          var name = item['name'];
                          if (filesize == null) {
                            name += '/';
                          } else {
                            isFile = true;
                          }
                          return ListTile(
                              title: Text(name),
                              onTap: () async {
                                if (isFile) {
                                  final link = await getTemporaryLink(path);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(link ??
                                              'getTemporaryLink error: $path')));
                                } else {
                                  await listFolder(path);
                                }
                              });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class Instructions extends StatelessWidget {
  const Instructions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'You need to get dropbox_key & dropbox_secret from https://www.dropbox.com/developers'),
          SizedBox(height: 20),
          Text('1. Update dropbox_key and dropbox_secret from main.dart'),
          SizedBox(height: 20),
          Text(
              "  const String dropbox_key = 'DROPBOXKEY';\n  const String dropbox_secret = 'DROPBOXSECRET';"),
          SizedBox(height: 20),
          Text(
              '2. (Android) Update dropbox_key from android/app/src/main/AndroidManifest.xml.\n  <data android:scheme="db-DROPBOXKEY" />'),
          SizedBox(height: 20),
          Text(
              '2. (iOS) Update dropbox_key from ios/Runner/Info.plist.\n  <string>db-DROPBOXKEY</string>'),
        ],
      ),
    );
  }
}

import 'package:hive_flutter/hive_flutter.dart';

import 'cloud_download_cache_service.dart';

class CloudDownloadCacheServiceImpl implements CloudDownloadCacheService {
  late Box<String> downloadBox;

  CloudDownloadCacheServiceImpl({required String boxName}) {
    init(boxName);
  }

  @override
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
    downloadBox = await Hive.openBox<String>(boxName);
  }

  @override
  Future<bool> get isOpened async {
    return await _openedCheck();
  }

  Future<dynamic> _openedCheck() async {
    return downloadBox.isOpen;
  }

  @override
  bool isContain(String musicName) {
    return _checkContain(musicName);
  }

  bool _checkContain(String musicName) {
    return downloadBox.containsKey(musicName);
  }

  @override
  void putName(String key, String value) async {
    await _save(key, value);
  }

  Future<void> _save(String key, value) async {
    await downloadBox.put(key, value);
  }

  @override
  bool isEmpty() {
    return _checkEmpty();
  }

  bool _checkEmpty() {
    return downloadBox.isEmpty;
  }

  @override
  Future<Box<String>> get box => _getBox();

  Future<Box<String>> _getBox() async {
    return downloadBox;
  }

  @override
  String? getKey(var key) {
    return _getKey(key);
  }

  String? _getKey(var key) {
    return downloadBox.get(key);
  }
}

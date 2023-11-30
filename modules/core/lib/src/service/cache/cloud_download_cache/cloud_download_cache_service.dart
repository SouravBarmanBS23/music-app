import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'cloud_download_cache_service_implementation.dart';

final cloudDownloadCacheServiceProvider =
    Provider.family<CloudDownloadCacheService, String>(
  (ref, boxName) => CloudDownloadCacheServiceImpl(boxName: boxName),
);

abstract class CloudDownloadCacheService {
  Future<void> init(String boxName);
  Future<bool> get isOpened;
  bool isContain(String musicName);
  bool isEmpty();
  void putName(String key, String value);
  Future<Box<String>> get box;
  String? getKey(var key);
}

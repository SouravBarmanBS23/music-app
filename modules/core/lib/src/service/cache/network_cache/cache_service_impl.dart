import 'package:hive_flutter/hive_flutter.dart';

import 'cache_service.dart';

class CacheServiceImpl implements CacheService {
  CacheServiceImpl();

  late Box box;

  static const String _boxName = "Student PT";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _bearerToken = "bearerToken";
  static const String _fcmToken = "fcmToken";

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox(_boxName);
  }

  @override
  Future<bool> get isLoggedIn async {
    return await _read(_isLoggedIn) ?? false;
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    await _save(_isLoggedIn, value);
  }

  @override
  Future<String?> get bearerToken async {
    return await _read(_bearerToken);
  }

  @override
  Future<void> setBearerToken(String value) async {
    await _save(_bearerToken, value);
  }

  @override
  Future<String?> get fcmToken async {
    return await _read(_fcmToken);
  }

  @override
  Future<void> setFcmToken(String value) async {
    await _save(_fcmToken, value);
  }

  @override
  Future<void> delete(String key) async {
    await box.delete(key);
  }

  @override
  Future<void> deleteAll() async {
    await box.clear();
  }

  Future<void> _save(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<dynamic> _read(String key) async {
    return box.get(key);
  }
}

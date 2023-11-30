import 'package:hive/hive.dart';

class HiveDB {
  static const _appDirectory = 'appDirectory';

  static Future<void> storeKeyInHive(String value) async {
    final box = await Hive.openBox<String>('app-directory');
    await box.put(_appDirectory, value);
    await box.close();
  }

  static Future<String?> retrieveDirectoryFromHive() async {
    final box = await Hive.openBox<String>('app-directory');
    final value = box.get(_appDirectory);
    await box.close();
    return value;
  }

  static Future<bool?> isEmpty() async {
    final box = await Hive.openBox<String>('app-directory');
    if (box.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

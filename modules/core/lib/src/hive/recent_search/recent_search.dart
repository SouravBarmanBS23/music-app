import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core.dart';

class RecentSearch extends Notifier{


  @override
  build() {
    // TODO: implement build
    final value  = ref.read(cacheServiceProvider);

    return value;
  }

  static Future<void> saveRecentSearches(List<dynamic> recentSearches) async {
    var box = Hive.box('recentSearches');
    if (box.isOpen) {
      box.addAll(recentSearches);
    } else {
      box = await Hive.openBox('recentSearches');

      box.addAll(recentSearches);
    }
  }

  static List<dynamic> getRecentSearches() {
    var box = Hive.box('recentSearches');
    var recentSearches = box.values.toList();
    if (recentSearches.isNotEmpty) {
      return recentSearches;
    }
    return [];
  }

  static void deleteRecentSearchItem() {
    var box = Hive.box('recentSearches');

    if (box.isNotEmpty) {
      box.clear();
    }
  }


}

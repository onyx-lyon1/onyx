import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static Future<E?> get<E>() async {
    if (kDebugMode) {
      print(E.runtimeType);
    }
    Box box = await Hive.openBox<E>("cached ${E.runtimeType}");
    if (box.containsKey("cache")) {
      return box.get("cache");
    } else {
      return null;
    }
  }

  static Future<void> set<E>(E data) async {
    Box box = await Hive.openBox<E>("cached ${E.runtimeType}");
    box.put("cache", data);
    box.close();
  }

  static Future<bool> exist<E>() async {
    Box box = await Hive.openBox<E>("cached ${E.runtimeType}");
    return box.containsKey("cache");
  }


}

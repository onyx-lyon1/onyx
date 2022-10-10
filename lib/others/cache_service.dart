import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static Future<E?> get<E>() async {
    Box<E> box = await Hive.openBox<E>("cached_$E");
    return box.get("cache");
  }

  static Future<void> set<E>(E data) async {
    Box box = await Hive.openBox<E>("cached_$E");
    box.put("cache", data);
  }

  static Future<bool> exist<E>() async {
    Box box = await Hive.openBox<E>("cached_$E");
    return box.containsKey("cache");
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static Future<E?> get<E>({int index = 0}) async {
    try {
      Box<E> box = await Hive.openBox<E>("cached_$E");
      return box.get("cache$index");
    } catch (e) {
      return null;
    }
  }

  static Future<void> set<E>(E data, {int index = 0}) async {
    Box box = await Hive.openBox<E>("cached_$E");
    box.put("cache$index", data);
  }

  static Future<bool> exist<E>({int index = 0}) async {
    Box box = await Hive.openBox<E>("cached_$E");
    return box.containsKey("cache$index");
  }

  static Future<void> reset<E>() async {
    await Hive.deleteBoxFromDisk("cached_$E");
  }
}

import 'dart:io';

import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

class SembastActionCache {
  static Database? _db;
  static final _store = StoreRef<String, Map<String, dynamic>>('actions');
  static const String _key = 'cache0';

  static Future<Database> openDb({String? path}) async {
    if (_db != null) return _db!;
    final dbPath = join(path ?? Directory.current.path, 'actions.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    return _db!;
  }

  static Future<ActionList> getActions() async {
    final db = await openDb();
    final map = await _store.record(_key).get(db);
    if (map == null) return ActionList(action: []);
    return ActionListMapper.fromMap(map);
  }

  static Future<void> putActions(ActionList actions) async {
    final db = await openDb();
    await _store.record(_key).put(db, actions.toMap());
  }

  static Future<void> clearActions() async {
    final db = await openDb();
    await _store.record(_key).delete(db);
  }
}

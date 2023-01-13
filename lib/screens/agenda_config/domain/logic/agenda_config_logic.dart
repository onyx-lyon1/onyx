import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

class LoadData {
  String encryptedData;
  String key;

  LoadData(this.encryptedData, this.key);
}

class AgendaConfigLogic {
  static Future<List<DirModel>> loadDirs(LoadData loadData) async {
    print("retrieveDirs");
    List<DirModel> dirs = [];
    final key = Key.fromBase64(loadData.key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(loadData.encryptedData), iv: iv);
    print("decrypted: ${decrypted.length}");
    final json = jsonDecode(decrypted);
    for (var dir in json) {
      dirs.add(DirModel.fromJson(dir));
    }
    return dirs;
  }

  static int urlToIndex(String url) {
    String resources = url.substring(url.indexOf("resources=") + 10);
    return int.parse(resources.substring(0, resources.indexOf("&")));
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

class AgendaConfigLogic {
  static Future<List<DirModel>> loadDirs(
      ({String encryptedData, String key, String iv}) loadData) async {
    List<DirModel> dirs = [];

    final key = Key.fromBase64(loadData.key);
    final iv = IV.fromBase64(loadData.iv);
    final encrypter = Encrypter(AES(key));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(loadData.encryptedData), iv: iv);
    final unCompressedData = utf8.decode(gzip.decode(base64.decode(decrypted)));
    final json = jsonDecode(unCompressedData);
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

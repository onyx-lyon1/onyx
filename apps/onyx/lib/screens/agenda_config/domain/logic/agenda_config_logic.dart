import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';

class AgendaConfigLogic {
  static Future<List<DirModel>> loadDirs(
      ({
        String encryptedData,
        String key,
        String iv,
        bool mock
      }) loadData) async {
    if (loadData.mock) return mockDirList;

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

  static const List<DirModel> mockDirList = [
    DirModel(name: "Root", identifier: 1, children: [
      DirModel(name: "Folder A", identifier: 2, children: [
        DirModel(name: "Subfolder A1", identifier: 3),
        DirModel(name: "Subfolder A2", identifier: 4),
      ]),
      DirModel(name: "Folder B", identifier: 5, children: [
        DirModel(name: "Subfolder B1", identifier: 6),
      ]),
    ]),
    DirModel(name: "Another Root", identifier: 7, children: [
      DirModel(name: "Folder X", identifier: 8),
      DirModel(name: "Folder Y", identifier: 9, children: [
        DirModel(name: "Subfolder Y1", identifier: 10),
        DirModel(name: "Subfolder Y2", identifier: 11),
      ]),
    ]),
    DirModel(name: "Folder C", identifier: 12),
    DirModel(name: "Folder D", identifier: 13, children: [
      DirModel(name: "Subfolder D1", identifier: 14),
    ]),
    DirModel(name: "Folder E", identifier: 15, children: [
      DirModel(name: "Subfolder E1", identifier: 16),
      DirModel(name: "Subfolder E2", identifier: 17),
      DirModel(name: "Subfolder E3", identifier: 18),
    ]),
    DirModel(name: "Folder F", identifier: 19, children: [
      DirModel(name: "Subfolder F1", identifier: 20),
      DirModel(name: "Subfolder F2", identifier: 21),
    ]),
    DirModel(name: "Folder G", identifier: 22),
    DirModel(name: "Folder H", identifier: 23, children: [
      DirModel(name: "Subfolder H1", identifier: 24),
      DirModel(name: "Subfolder H2", identifier: 25),
    ]),
    // Add more directories as needed
  ];
}

import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:onyx/screens/agenda_config/agenda_config_export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaConfigLogic {
  static Future<List<DirModel>> loadDirs(
      ({
        String encryptedData,
        String key,
        String iv,
        bool mock,
        AppLocalizations appLocalizations,
      }) loadData) async {
    if (loadData.mock) return mockDirList(loadData.appLocalizations);

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

  static List<int> urlToIndexs(String url) {
    String resources =
        RegExp(r"resources=([0-9,]+)").firstMatch(url)!.group(0)!.split("=")[1];
    return resources.split(",").map((e) => int.parse(e)).toList();
  }

  static List<DirModel> mockDirList(AppLocalizations appLocalizations) => [
        DirModel(name: appLocalizations.root, identifier: 1, children: [
          DirModel(
              name: "${appLocalizations.folder} A",
              identifier: 2,
              children: [
                DirModel(
                    name: "${appLocalizations.subFolder} A1", identifier: 3),
                DirModel(
                    name: "${appLocalizations.subFolder} A2", identifier: 4),
              ]),
          DirModel(
              name: "${appLocalizations.folder} B",
              identifier: 5,
              children: [
                DirModel(
                    name: "${appLocalizations.subFolder} B1", identifier: 6),
              ]),
        ]),
        DirModel(name: appLocalizations.anotherRoot, identifier: 7, children: [
          DirModel(name: "${appLocalizations.folder} X", identifier: 8),
          DirModel(
              name: "${appLocalizations.folder} Y",
              identifier: 9,
              children: [
                DirModel(
                    name: "${appLocalizations.subFolder} Y1", identifier: 10),
                DirModel(
                    name: "${appLocalizations.subFolder} Y2", identifier: 11),
              ]),
        ]),
        DirModel(name: "${appLocalizations.folder} C", identifier: 12),
        DirModel(
            name: "${appLocalizations.folder} D",
            identifier: 13,
            children: [
              DirModel(
                  name: "${appLocalizations.subFolder} D1", identifier: 14),
            ]),
        DirModel(
            name: "${appLocalizations.folder} E",
            identifier: 15,
            children: [
              DirModel(
                  name: "${appLocalizations.subFolder} E1", identifier: 16),
              DirModel(
                  name: "${appLocalizations.subFolder} E2", identifier: 17),
              DirModel(
                  name: "${appLocalizations.subFolder} E3", identifier: 18),
            ]),
        DirModel(
            name: "${appLocalizations.folder} F",
            identifier: 19,
            children: [
              DirModel(
                  name: "${appLocalizations.subFolder} F1", identifier: 20),
              DirModel(
                  name: "${appLocalizations.subFolder} F2", identifier: 21),
            ]),
        DirModel(name: "${appLocalizations.folder} G", identifier: 22),
        DirModel(
            name: "${appLocalizations.folder} H",
            identifier: 23,
            children: [
              DirModel(
                  name: "${appLocalizations.subFolder} H1", identifier: 24),
              DirModel(
                  name: "${appLocalizations.subFolder} H2", identifier: 25),
            ]),
        // Add more directories as needed
      ];
}

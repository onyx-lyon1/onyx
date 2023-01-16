import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/dart_izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/izly/domain/model/izly_credential.dart';

class IzlyLogic {
  static Future<IzlyCredential?> getIzlyCredential(
      {String username = '', String password = ''}) async {
    if (username.isEmpty || password.isEmpty) {
      if (await CacheService.exist<IzlyCredential>()) {
        return await CacheService.get<IzlyCredential>();
      }
    } else {
      await CacheService.set<IzlyCredential>(
          IzlyCredential(username: username, password: password));
      return IzlyCredential(username: username, password: password);
    }
    return null;
  }

  static Future<Uint8List> getQrCode(IzlyClient? izlyClient) async {
    Box box = await Hive.openBox<List<dynamic>>("cached_qr_code");
    List<dynamic> qrCodes = box.get("qr_code", defaultValue: []);
    if (izlyClient != null) {
      qrCodes.addAll(await izlyClient.getNQRCode((3 - qrCodes.length)));
    }
    Uint8List qrCode;
    if (qrCodes.isNotEmpty) {
      qrCode = qrCodes.removeAt(0);
      box.put("qr_code", qrCodes);
    } else {
      qrCode = (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
    }

    return qrCode;
  }
}

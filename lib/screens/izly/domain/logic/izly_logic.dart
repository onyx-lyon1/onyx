import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/izly/domain/model/izly_credential.dart';

class IzlyLogic {
  static Future<IzlyCredential> getIzlyCredential(
      {String username = '', String password = ''}) async {
    if (username.isEmpty || password.isEmpty) {
      if (await CacheService.exist<IzlyCredential>()) {
        return (await CacheService.get<IzlyCredential>())!;
      }
    } else {
      await CacheService.set<IzlyCredential>(
          IzlyCredential(username: username, password: password));
      return IzlyCredential(username: username, password: password);
    }
    throw Exception("No credentials");
  }

  static Future<Uint8List> getQrCode() async {
    Box box = await Hive.openBox<List<dynamic>>("cached_qr_code");
    List<dynamic> qrCodes = box.get("qr_code", defaultValue: []);
    Uint8List qrCode;
    if (qrCodes.isNotEmpty) {
      qrCode = qrCodes.removeAt(0);
      box.put("qr_code", qrCodes);
    } else {
      qrCode = (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
    }
    return qrCode;
  }

  static Future<bool> completeQrCodeCache(IzlyClient izlyClient) async {
    Box box = await Hive.openBox<List<dynamic>>("cached_qr_code");
    List<dynamic> qrCodes = box.get("qr_code", defaultValue: []);
    try {
      qrCodes.addAll(await izlyClient.getNQRCode((3 - qrCodes.length)));
      box.put("qr_code", qrCodes);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<void> reloginIfNeeded(IzlyClient izlyClient) async {
    if (!(await izlyClient.isLogged())) {
      await izlyClient.login();
    }
  }

  static Future<RequestDataModel> getTransferUrl(
      IzlyClient izlyClient, double amount) async {
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getTransferPaymentUrl(amount);
  }

  static Future<RequestDataModel> rechargeWithCB(
      IzlyClient izlyClient, double amount, CbModel cb) async {
    await reloginIfNeeded(izlyClient);
    return await izlyClient.rechargeWithCB(amount, cb);
  }

  static Future<List<CbModel>> getCb(IzlyClient izlyClient) async {
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getAvailableCBs();
  }

  static Future<bool> rechargeViaSomeoneElse(IzlyClient izlyClient,
      double amount, String email, String message) async {
    await reloginIfNeeded(izlyClient);
    return await izlyClient.rechargeViaSomeoneElse(amount, email, message);
  }
}

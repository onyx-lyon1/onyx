import 'package:flutter/services.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';

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
    if (!(await CacheService.exist<IzlyQrCodeList>())) {
      return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
    } else {
      List<IzlyQrCode> qrCodeModels =
          (await CacheService.get<IzlyQrCodeList>())!.qrCodes;
      for (IzlyQrCode qrCodeModel in qrCodeModels) {
        if (qrCodeModel.expirationDate.isBefore(DateTime.now())) {
          qrCodeModels.remove(qrCodeModel);
        }
      }
      if (qrCodeModels.isEmpty) {
        return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
      } else {
        IzlyQrCode qrCodeModel = qrCodeModels.removeAt(0);
        await CacheService.set<IzlyQrCodeList>(
            IzlyQrCodeList(qrCodes: qrCodeModels));
        return qrCodeModel.qrCode;
      }
    }
  }

  static Future<bool> completeQrCodeCache(IzlyClient izlyClient) async {
    List<IzlyQrCode> qrCodes =
        ((await CacheService.get<IzlyQrCodeList>())?.qrCodes) ?? [];
    try {
      qrCodes.addAll((await izlyClient.getNQRCode((3 - qrCodes.length)))
          .map((e) => IzlyQrCode(
              qrCode: e,
              expirationDate: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day + 1, 14)))
          .toList());
      await CacheService.set<IzlyQrCodeList>(IzlyQrCodeList(qrCodes: qrCodes));
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

  static Future<RequestData> getTransferUrl(
      IzlyClient izlyClient, double amount) async {
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getTransferPaymentUrl(amount);
  }

  static Future<RequestData> rechargeWithCB(
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

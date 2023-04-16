import 'package:flutter/services.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/screens/izly/domain/model/izly_credential.dart';
import 'package:onyx/screens/izly/domain/model/izly_qrcode_model.dart';
import 'package:onyx/screens/izly/domain/model/izly_qrcode_model_wrapper.dart';

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
    if (!(await CacheService.exist<IzlyQrCodeModelWrapper>())) {
      return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
    } else {
      List<IzlyQrCodeModel> qrCodeModels =
          (await CacheService.get<IzlyQrCodeModelWrapper>())!.qrCodes;
      for (IzlyQrCodeModel qrCodeModel in qrCodeModels) {
        if (qrCodeModel.expirationDate.isBefore(DateTime.now())) {
          qrCodeModels.remove(qrCodeModel);
        }
      }
      if (qrCodeModels.isEmpty) {
        return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
      } else {
        IzlyQrCodeModel qrCodeModel = qrCodeModels.removeAt(0);
        await CacheService.set<IzlyQrCodeModelWrapper>(
            IzlyQrCodeModelWrapper(qrCodes: qrCodeModels));
        return qrCodeModel.qrCode;
      }
    }
  }

  static Future<bool> completeQrCodeCache(IzlyClient izlyClient) async {
    List<IzlyQrCodeModel> qrCodes =
        ((await CacheService.get<IzlyQrCodeModelWrapper>())?.qrCodes) ?? [];
    try {
      qrCodes.addAll((await izlyClient.getNQRCode((3 - qrCodes.length)))
          .map((e) => IzlyQrCodeModel(
              qrCode: e,
              expirationDate: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day + 1, 14)))
          .toList());
      await CacheService.set<IzlyQrCodeModelWrapper>(
          IzlyQrCodeModelWrapper(qrCodes: qrCodes));
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

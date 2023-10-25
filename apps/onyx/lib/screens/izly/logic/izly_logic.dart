import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';

class IzlyLogic {
  static Future<Uint8List> getQrCode() async {
    if (Res.mock) {
      return (await rootBundle.load('assets/izly_mock_qr-code.png'))
          .buffer
          .asUint8List();
    }
    if (!(await CacheService.exist<List<IzlyQrCode>>())) {
      return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
    } else {
      List<IzlyQrCode> qrCodeModels =
          (await CacheService.get<List<IzlyQrCode>>())!;
      qrCodeModels.removeWhere(
          (element) => element.expirationDate.isBefore(DateTime.now()));

      if (qrCodeModels.isEmpty) {
        return (await rootBundle.load('assets/izly.png')).buffer.asUint8List();
      } else {
        IzlyQrCode qrCodeModel = qrCodeModels.removeAt(0);
        await CacheService.set<List<IzlyQrCode>>(qrCodeModels);
        return qrCodeModel.qrCode;
      }
    }
  }

  static Future<bool> completeQrCodeCache(IzlyClient izlyClient) async {
    if (Res.mock) {
      return true;
    }
    List<IzlyQrCode> qrCodes = await CacheService.get<List<IzlyQrCode>>() ?? [];
    try {
      qrCodes.addAll((await izlyClient.getNQRCode((3 - qrCodes.length)))
          .map((e) => IzlyQrCode(
              qrCode: e,
              expirationDate: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day + 1, 14)))
          .toList());
      await CacheService.set<List<IzlyQrCode>>(qrCodes);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<int> getAvailableQrCodeCount() async {
    List<IzlyQrCode> qrCodes = await CacheService.get<List<IzlyQrCode>>() ?? [];
    return qrCodes.length;
  }

  static Future<void> reloginIfNeeded(IzlyClient izlyClient) async {
    if (Res.mock) {
      return;
    }
    if (!(await izlyClient.isLogged())) {
      await izlyClient.login();
    }
  }

  static Future<({Map<String, dynamic> body, String url})> getTransferUrl(
      IzlyClient izlyClient, double amount) async {
    if (Res.mock) {
      return (url: "google.com", body: const <String, dynamic>{});
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getTransferPaymentUrl(amount);
  }

  static Future<({Map<String, dynamic> body, String url})> rechargeWithCB(
      IzlyClient izlyClient, double amount, CbModel cb) async {
    if (Res.mock) {
      return (url: "google.com", body: const <String, dynamic>{});
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.rechargeWithCB(amount, cb);
  }

  static Future<List<CbModel>> getCb(IzlyClient izlyClient) async {
    if (Res.mock) {
      return [CbModel("La CB de test", "123 456 789 123 456")];
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getAvailableCBs();
  }

  static Future<bool> rechargeViaSomeoneElse(IzlyClient izlyClient,
      double amount, String email, String message) async {
    if (Res.mock) {
      return true;
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.rechargeViaSomeoneElse(amount, email, message);
  }

  static Future<void> addRestaurantToFavourite(
      RestaurantModel restaurant) async {
    final box = await Hive.openBox("favourite_restaurant");
    box.put(restaurant.id, true);
  }

  static Future<void> removeRestaurantToFavourite(
      RestaurantModel restaurant) async {
    final box = await Hive.openBox("favourite_restaurant");
    box.put(restaurant.id, false);
  }

  static Future<bool> isRestaurantFavourite(RestaurantModel restaurant) async {
    final box = await Hive.openBox("favourite_restaurant");
    return box.get(restaurant.id, defaultValue: false);
  }

  static Future<List<IzlyPaymentModel>> getUserPayments(
      IzlyClient izlyClient) async {
    if (Res.mock) {
      return paymentModelListMock;
    }

    await reloginIfNeeded(izlyClient);

    try {
      return await izlyClient.getUserPayments();
    } catch (e) {
      return [];
    }
  }

  static final List<IzlyPaymentModel> paymentModelListMock = [
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: false,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: false,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: "12/12/2020",
      amountSpent: "12€",
      isSucess: true,
    ),
  ];
}

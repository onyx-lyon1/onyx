import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/res.dart';

class IzlyLogic {
  static Future<Uint8List> getQrCode(IzlyClient izlyClient) async {
    if (Res.mock) {
      return (await rootBundle.load(Res.izlyMockQrCodePath))
          .buffer
          .asUint8List();
    }
    return await izlyClient.getQRCode();
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
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: false,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: false,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
    IzlyPaymentModel(
      paymentTime: DateTime(12, 12, 2020),
      amountSpent: 12,
      isSucess: true,
    ),
  ];
}

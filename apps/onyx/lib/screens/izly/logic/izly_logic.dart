import 'package:flutter/services.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/res.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class IzlyLogic {
  static Future<Uint8List> getQrCode(IzlyClient izlyClient) async {
    if (Res.mock) {
      return (await rootBundle.load(
        Res.izlyMockQrCodePath,
      )).buffer.asUint8List();
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
    IzlyClient izlyClient,
    double amount,
  ) async {
    if (Res.mock) {
      return (url: "google.com", body: const <String, dynamic>{});
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.getTransferPaymentUrl(amount);
  }

  static Future<({Map<String, dynamic> body, String url})> rechargeWithCB(
    IzlyClient izlyClient,
    double amount,
    CbModel cb,
  ) async {
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

  static Future<bool> rechargeViaSomeoneElse(
    IzlyClient izlyClient,
    double amount,
    String email,
    String message,
  ) async {
    if (Res.mock) {
      return true;
    }
    await reloginIfNeeded(izlyClient);
    return await izlyClient.rechargeViaSomeoneElse(amount, email, message);
  }

  static Future<Database> _getDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'favourite_restaurant.db');
    return await databaseFactoryIo.openDatabase(dbPath);
  }

  static final _store = stringMapStoreFactory.store('favourite_restaurant');

  static Future<void> addRestaurantToFavourite(
    RestaurantModel restaurant,
  ) async {
    final db = await _getDb();
    await _store.record(restaurant.id.toString()).put(db, {'favourite': true});
  }

  static Future<void> removeRestaurantToFavourite(
    RestaurantModel restaurant,
  ) async {
    final db = await _getDb();
    await _store.record(restaurant.id.toString()).put(db, {'favourite': false});
  }

  static Future<bool> isRestaurantFavourite(RestaurantModel restaurant) async {
    final db = await _getDb();
    final record =
        await _store.record(restaurant.id.toString()).get(db) as Map?;
    return record != null ? (record['favourite'] ?? false) : false;
  }

  static Future<List<IzlyPaymentModel>> getUserPayments(
    IzlyClient izlyClient,
  ) async {
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

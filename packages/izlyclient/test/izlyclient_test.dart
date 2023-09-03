import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

import 'package:izlyclient/izlyclient.dart';

void main() {
  late IzlyClient izlyClient;
  DotEnv env = DotEnv(includePlatformEnvironment: true);

  setUp(() {
    env.load();
    izlyClient =
        IzlyClient(env['IZLY_USERNAME'] ?? "", env['IZLY_PASSWORD'] ?? "");
  });

  test('Login-lougout test', () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test("get balance", () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    var balance = await izlyClient.getBalance();
    expect(balance, isNotNull);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test('Get QRCode test', () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    var qrCode = await izlyClient.getNQRCode(3);
    expect(qrCode, isNotNull);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test("rechager with transfer", () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    RequestData rechargement = await izlyClient.getTransferPaymentUrl(10.0);
    expect(rechargement, isNotNull);
    expect(rechargement.url, isNotNull);
    expect(rechargement.body.keys, isEmpty);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test("rechager with credit card", () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    final List<CbModel> cbs = (await izlyClient.getAvailableCBs());
    final RequestData rechargement =
        await izlyClient.rechargeWithCB(10.0, cbs.first);
    expect(rechargement.url, isNotNull);
    expect(rechargement.body.keys.length, 4);
    final RequestData rechargementNewCb =
        await izlyClient.rechargeWithCB(10.0, cbs.last);
    expect(rechargementNewCb.url, isNotNull);
    expect(rechargementNewCb.body.keys.length, 27);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test("recharge via someone else", () async {
    await izlyClient.login();
    expect(await izlyClient.isLogged(), true);
    bool rechargement = await izlyClient.rechargeViaSomeoneElse(
        10.0, env['IZLY_USERNAME'] ?? "", "un petit message");
    expect(rechargement, true);
    await izlyClient.logout();
    expect(await izlyClient.isLogged(), false);
  });

  test("get menu crous", () async {
    var menuCrous = await IzlyClient.getRestaurantCrous();
    expect(menuCrous, isNotNull);
  });
}

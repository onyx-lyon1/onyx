import 'package:dartus/tomuss.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';

class AuthentificationLogic {
  static Future<Credential> fetchCredential(
      {String? username, String? password}) async {
    if (Res.mock) {
      return mockCredential;
    }
    Box<Credential> authBox =
        await Hive.openBox<Credential>("authentification");
    Credential? auth;
    if (username != null && password != null) {
      auth = Credential(username, password);
    } else {
      auth = authBox.get("credential");
    }

    if (auth == null) {
      throw Exception("No credential");
    }

    return auth;
  }

  static Future<bool> firstLogin() async {
    Box<Credential> authBox =
        await Hive.openBox<Credential>("authentification");
    Credential? auth = authBox.get("credential");
    return auth == null;
  }

  static Future<Dartus> login(
      {required String username,
      required String password,
      required bool keepLogedIn}) async {
    if (Res.mock) {
      return Dartus(Authentication(Credential(username, password)));
    }
    Box<Credential> authBox =
        await Hive.openBox<Credential>("authentification");
    final Dartus tomuss =
        Dartus(Authentication(Credential(username, password)));
    try {
      if (await tomuss.authenticate()) {
        if (keepLogedIn) {
          if (!authBox.isOpen) {
            authBox = await Hive.openBox<Credential>("authentification");
          }
          await authBox.put("credential", Credential(username, password));
        }
      } else {
        throw Exception("Authentification failed");
      }
    } catch (e) {
      throw Exception("Authentification failed");
    }
    return tomuss;
  }

  static final Credential mockCredential =
      Credential("mockUsername", "mockPassword");
}

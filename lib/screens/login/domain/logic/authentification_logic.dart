import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/login/login_export.dart';

class AuthentificationLogic {
  static Future<AuthenticationModel> fetchCredential(
      {String? username, String? password}) async {
    if (Res.mock) {}
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    AuthenticationModel? auth;
    if (username != null && password != null) {
      auth = AuthenticationModel(username: username, password: password);
    } else {
      auth = authBox.get("credential");
    }

    if (auth == null) {
      throw Exception("No credential");
    }

    return auth;
  }

  static Future<bool> firstLogin() async {
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    AuthenticationModel? auth = authBox.get("credential");
    return auth == null;
  }

  static Future<tomusslib.Dartus> login(
      {required String username,
      required String password,
      required bool keepLogedIn}) async {
    if (Res.mock) {
      return tomusslib.Dartus(tomusslib.Authentication(username, password));
    }
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    final tomusslib.Dartus tomuss =
        tomusslib.Dartus(tomusslib.Authentication(username, password));
    try {
      if (await tomuss.authenticate()) {
        if (keepLogedIn) {
          if (!authBox.isOpen) {
            authBox =
                await Hive.openBox<AuthenticationModel>("authentification");
          }
          await authBox.put("credential",
              AuthenticationModel(username: username, password: password));
        }
      } else {
        throw Exception("Authentification failed");
      }
    } catch (e) {
      throw Exception("Authentification failed");
    }
    return tomuss;
  }

  static final AuthenticationModel mockCredential =
      AuthenticationModel(username: "mockUsername", password: "mockPassword");
}

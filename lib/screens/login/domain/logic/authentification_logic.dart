import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:dartus/tomuss.dart' as tomusslib;

class AuthentificationLogic {
  static Future<AuthenticationModel> fetchCredential(
      {String? username, String? password}) async {
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

  static Future<tomusslib.Dartus> login(
      {required String username,
      required String password,
      required bool keepLogedIn}) async {
    Box<AuthenticationModel> authBox =
        await Hive.openBox<AuthenticationModel>("authentification");
    final tomusslib.Dartus tomuss =
        tomusslib.Dartus(tomusslib.Authentication(username, password));
    try {
      if (await tomuss.authenticate()) {
        if (keepLogedIn) {
          if (!authBox.isOpen) {
            authBox = await Hive.openBox<AuthenticationModel>("authentification");
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

  static Future<void> logout() async {}
}

import 'package:dartus/tomuss.dart' as tomusslib;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/model/authentication.dart';

class AuthentificationBackend {
  static Future<Authentication> fetchCredential(
      {String? username, String? password}) async {
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    Authentication? auth;
    if (username != null && password != null) {
      auth = Authentication(username: username, password: password);
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
    Box<Authentication> authBox =
        await Hive.openBox<Authentication>("authentification");
    final tomusslib.Dartus tomuss =
        tomusslib.Dartus(tomusslib.Authentication(username, password));
    try {
      if (await tomuss.authenticate()) {
        if (keepLogedIn) {
          if (!authBox.isOpen) {
            authBox = await Hive.openBox<Authentication>("authentification");
          }
          await authBox.put("credential",
              Authentication(username: username, password: password));
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

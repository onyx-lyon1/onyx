import 'package:dotenv/dotenv.dart';
import 'package:lyon1agendaclient/src/utils/agenda_url.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:test/test.dart';

void main() async {
  late Lyon1CasClient auth;
  DotEnv env = DotEnv(includePlatformEnvironment: true);
  setUpAll(() async {
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";
    if (username.isEmpty || password.isEmpty) {
      throw Exception(
          "Check your .env file, username and/or password are empty");
    }
    auth = Lyon1CasClient();
    final bool ok =
        (await auth.authenticate(Credential(username, password))).authResult;
    expect(ok, equals(true));
  });

  test('getURL', () async {
    expect(auth.isAuthenticated, equals(true));

    final AgendaURL agendaURL = AgendaURL(auth);
    final String url = await agendaURL.getURL();
    print(url);
    expect(url.isNotEmpty, equals(true));
    expect(url.contains(RegExp("resources=[0-9,]+&")), equals(true));
    expect(url.contains(RegExp("projectId=[0-9]+&")), equals(true));
  });

  tearDownAll(() async {
    auth.logout();
  });
}

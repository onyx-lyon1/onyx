import 'package:dotenv/dotenv.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1agendaclient/src/utils/agenda_url.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:test/test.dart';

void main() async {
  late final Lyon1CasClient auth;
  late final Lyon1AgendaClient agendaClient;
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

    agendaClient = Lyon1AgendaClient(AgendaURL(), auth);
    await agendaClient.login();
    expect(await agendaClient.isLoggedIn(), equals(true));
  });

  test('Login to ADE', () async {
    final Lyon1AgendaClient agendaClient = Lyon1AgendaClient(AgendaURL(), auth);
    await agendaClient.login();
    expect(await agendaClient.isLoggedIn(), equals(true));
  });

  test('getAgenda from URL', () async {
    final data = await agendaClient.getResources;
    expect(data.isEmpty, equals(false));
  });
}

import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  late Lyon1CasClient authOK;
  late Credential credential;

  DotEnv env = DotEnv(includePlatformEnvironment: true);

  setUpAll(() {
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }

    authOK = Lyon1CasClient();
    credential = Credential(username, password);
    Lyon1CasClient.registerAdapters();
  });

  test('getExecToken', () async {
    expect(await authOK.getExecToken(), isNotEmpty);
  });

  test('authenticate.ok', () async {
    final bool isAuthenticated =
        (await authOK.authenticate(credential)).authResult;
    expect(isAuthenticated, equals(true));
    expect((await authOK.checkAuthentificated()), true);
  });

  test("authentificate with cookies", () async {
    var authReturn = await authOK.authenticate(credential);
    await authOK.logout();
    expect(
        (await authOK.authenticate(
                authReturn.credential.copyWith(username: "", password: "")))
            .authResult,
        true);
  });

  test('authenticate.fail', () async {
    await authOK.logout();
    Lyon1CasClient authBAD = Lyon1CasClient();
    final bool isAuthenticated = (await authBAD
            .authenticate(Credential("p1234567", "not_valid_password")))
        .authResult;

    final String cookies = await authOK.getCasCookies();

    expect(isAuthenticated, equals(false));
    expect(cookies, isNot(contains("TGC=")));
  });
}

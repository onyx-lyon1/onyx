import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  late Lyon1ExamenClient examClient;
  late Credential creds;

  DotEnv env = DotEnv(includePlatformEnvironment: true);
  setUpAll(() async {
    Lyon1CasClient.registerAdapters();
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }
    creds = Credential(username, password);
    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    await lyon1Cas.authenticate(creds);
    assert(lyon1Cas.isAuthenticated);
    examClient = Lyon1ExamenClient(lyon1Cas);
  });

  test("getExams", () async {
    final exams = await examClient.fetchExams();
    expect(exams, isNotEmpty);
  });
}

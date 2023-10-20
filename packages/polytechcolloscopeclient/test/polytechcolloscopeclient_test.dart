import 'package:dotenv/dotenv.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';
import 'package:test/test.dart';

Future<void> main() async {
  DotEnv env = DotEnv(includePlatformEnvironment: true);
  late PolytechColloscopeClient client;

  late final int id;

  late final String name;
  late final String surname;

  setUpAll(() {
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";

    id = int.parse(env['ID'] ?? "0");

    name = env['NAME'] ?? "";
    surname = env['SURNAME'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }

    client = PolytechColloscopeClient(username, password);
  });

  test('Fetch all Students IDs (first year)',
      () async => {expect(await client.fetchStudents(Year.first), isNotEmpty)});

  test(
      'Fetch all Students IDs (second year)',
      () async =>
          {expect(await client.fetchStudents(Year.second), isNotEmpty)});

  test(
      'Get Colloscope wrong ID',
      () async => {
            expect(client.getColloscope(Year.second, Student("", 651635)),
                throwsStateError)
          });

  test(
      'Get Colloscope',
      () async => {
            expect(await client.getColloscope(Year.second, Student("", id)),
                isNotNull)
          });

  test('Get Colloscope', () async {
    final StudentColloscope colloscope =
        await client.getColloscope(Year.second, Student("", id));
    expect(colloscope, isNotNull);
    expect(colloscope.student, isNotNull);
    expect(colloscope.trinomeId, isNotNull);
    expect(colloscope.kholles, isNotEmpty);
  });

  test(
      "Fetch a student",
      () async => {
            expect(await client.fetchStudent(Year.second, name, surname),
                isNotNull)
          });

  test('Fetch a student', () async {
    final StudentColloscope colloscope =
        await client.getColloscope(Year.second, Student("", id));
    expect(colloscope, isNotNull);
    expect(colloscope.student, isNotNull);
    expect(colloscope.student.id, isNotNull);
    expect(colloscope.trinomeId, isNotNull);
    expect(colloscope.kholles, isNotEmpty);
  });
}

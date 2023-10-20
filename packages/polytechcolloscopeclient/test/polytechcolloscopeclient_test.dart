import 'package:dotenv/dotenv.dart';
import 'package:polytechcolloscopeclient/polytechcolloscopeclient.dart';
import 'package:test/test.dart';

Future<void> main() async {
  DotEnv env = DotEnv(includePlatformEnvironment: true);

  env.load();
  final String username = env['USERNAME'] ?? "";
  final String password = env['PASSWORD'] ?? "";

  if (username.isEmpty || password.isEmpty) {
    fail("username or password were empty. check your envt variables");
  }

  PolytechColloscopeClient client =
      PolytechColloscopeClient(username, password);

  var students = await client.fetchStudents(Year.first);
  print(students);

  var colloscope = await client.getColloscope(Year.first, 828);
  print(colloscope);
}

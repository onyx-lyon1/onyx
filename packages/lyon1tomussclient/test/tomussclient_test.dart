import 'package:dotenv/dotenv.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1tomussclient/src/rust/cas.dart';
import 'package:lyon1tomussclient/src/rust/frb_generated.dart';
import 'package:lyon1tomussclient/src/utils/urlcreator.dart';
import 'package:test/test.dart';

void main() async {
  late Lyon1TomussClient tomussOK;

  DotEnv env = DotEnv(includePlatformEnvironment: true);
  setUpAll(() async {
    await RustLib.init();
    Lyon1TomussClient.registerAdapters();
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }

    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    await lyon1Cas.authenticateUser(username: username, password: password);
    tomussOK = Lyon1TomussClient(lyon1Cas);
  });

  test('TomussClient.getPage', () async {
    final ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(URLCreator.basic());

    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    expect(parsedPage.teachingunits, isNotNull);
    expect(parsedPage.semesters!.isNotEmpty, equals(true));
    expect(parsedPage.teachingunits!.isNotEmpty, equals(true));
  });

  test('Dartus.getPage x2', () async {
    final ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(URLCreator.basic());
    expect(parsedPageOpt == null, equals(false));
  }, timeout: Timeout.parse("5m"));

  test('Dartus.getPage timeout', () async {
    ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(URLCreator.basic());
    for (int i = 0; i < 5; i++) {
      parsedPageOpt =
          await tomussOK.getParsedPage(URLCreator.basic(), autoRefresh: false);
    }
    expect(parsedPageOpt == null, equals(false));
    expect(parsedPageOpt!.isTimedOut, equals(true));
    expect(parsedPageOpt.semesters, isNull);
    expect(parsedPageOpt.teachingunits, isNull);
  });

  test("change un enum", () async {
    final ParsedPage? parsedPageOpt = await tomussOK
        .getParsedPage(URLCreator.currentSemester(DateTime.now()));
    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    Enumeration? enumeration;
    for (var i in parsedPage.teachingunits!) {
      if (i.enumerations.isNotEmpty) {
        for (var j in i.enumerations) {
          if (j.value != null && j.values.length > 1 && j.modifiable) {
            enumeration = j;
            break;
          }
        }
        if (enumeration != null) {
          break;
        }
      }
    }
    expect(enumeration == null, equals(false));
    String prevValue = enumeration!.value!;
    Enumeration newEnumeration = await enumeration.updateValue(
        enumeration.values[
            (enumeration.values.indexOf(enumeration.value!) + 1) %
                enumeration.values.length],
        parsedPage.teachingunits!.first.ticket);
    expect(newEnumeration.value == prevValue, equals(false));
  });

  test('download an upload', () async {
    final ParsedPage? parsedPageOpt = await tomussOK
        .getParsedPage(URLCreator.currentSemester(DateTime.now()));
    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    Upload? upload;
    for (var i in parsedPage.teachingunits!) {
      if (i.uploads.isNotEmpty) {
        upload = i.uploads.first;
        break;
      }
    }
    expect(upload == null, equals(false));
    List<int> file =
        await upload!.getContent(parsedPage.teachingunits!.first.ticket);
    expect(file.isNotEmpty, equals(true));
  });

  test('Dartus.currentSemester()', () async {
    expect(URLCreator.currentSemester(DateTime.parse("20220124")),
        "https://tomuss.univ-lyon1.fr/S/2022/Printemps");

    expect(URLCreator.currentSemester(DateTime.parse("20211129")),
        "https://tomuss.univ-lyon1.fr/S/2021/Automne");

    expect(URLCreator.previousSemester(DateTime.parse("20220124")),
        "https://tomuss.univ-lyon1.fr/S/2021/Automne");

    expect(URLCreator.previousSemester(DateTime.parse("20211129")),
        "https://tomuss.univ-lyon1.fr/S/2021/Printemps");
  });
}

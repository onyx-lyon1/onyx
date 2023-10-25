import 'package:dotenv/dotenv.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1tomussclient/src/utils/urlcreator.dart';
import 'package:test/test.dart';

void main() async {
  late Lyon1TomussClient tomussOK;
  late Credential credsOK;

  DotEnv env = DotEnv(includePlatformEnvironment: true);
  setUpAll(() async {
    env.load();
    final String username = env['USERNAME'] ?? "";
    final String password = env['PASSWORD'] ?? "";

    if (username.isEmpty || password.isEmpty) {
      fail("username or password were empty. check your envt variables");
    }
    credsOK = Credential(username, password);
    Lyon1CasClient lyon1Cas = Lyon1CasClient();
    await lyon1Cas.authenticate(credsOK);
    tomussOK = Lyon1TomussClient(lyon1Cas);
  });

  test('Dartus.getPage', () async {
    final ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(URLCreator.basic());

    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    expect(parsedPage.teachingunits, isNotNull);
    expect(parsedPage.semesters.isNotEmpty, equals(true));
    expect(parsedPage.teachingunits.isNotEmpty, equals(true));
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
    final ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(Lyon1TomussClient.currentSemester().url);
    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    Enumeration? enumeration;
    for (var i in parsedPage.teachingunits) {
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
        parsedPage.teachingunits.first.ticket);
    expect(newEnumeration.value == prevValue, equals(false));
  });

  test('download an upload', () async {
    final ParsedPage? parsedPageOpt =
        await tomussOK.getParsedPage(Lyon1TomussClient.currentSemester().url);
    expect(parsedPageOpt == null, equals(false));
    final ParsedPage parsedPage = parsedPageOpt ?? ParsedPage.empty();
    expect(parsedPage.semesters, isNotNull);
    Upload? upload;
    for (var i in parsedPage.teachingunits) {
      if (i.uploads.isNotEmpty) {
        upload = i.uploads.first;
        break;
      }
    }
    expect(upload == null, equals(false));
    List<int> file =
        await upload!.getContent(parsedPage.teachingunits.first.ticket);
    expect(file.isNotEmpty, equals(true));
  });

  test('Dartus.currentSemester()', () async {
    expect(Lyon1TomussClient.currentSemester().url,
        "https://tomuss.univ-lyon1.fr/S/2022/Printemps");

    expect(
        URLCreator.semesterFromName(
            URLCreator.currentSemesterName(DateTime.parse("20211129"))),
        "https://tomuss.univ-lyon1.fr/S/2021/Automne");

    expect(
        URLCreator.semesterFromName(
            URLCreator.currentSemesterName(DateTime.parse("20220124"))),
        "https://tomuss.univ-lyon1.fr/S/2021/Automne");

    expect(
        URLCreator.semesterFromName(
            URLCreator.currentSemesterName(DateTime.parse("20211129"))),
        "https://tomuss.univ-lyon1.fr/S/2021/Printemps");
  });
}

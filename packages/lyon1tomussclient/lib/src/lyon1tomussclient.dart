import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:hive/hive.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1tomussclient/src/parser/htmlparser.dart';
import 'package:lyon1tomussclient/src/utils/urlcreator.dart';

class Lyon1TomussClient {
  final Lyon1CasClient _authentication;

  const Lyon1TomussClient(Lyon1CasClient authentication)
      : _authentication = authentication;

  Lyon1CasClient get lyon1Cas => _authentication;

  static void registerAdapters() {
    Hive.registerAdapter(EnumerationAdapter());
    Hive.registerAdapter(GradeAdapter());
    Hive.registerAdapter(PresenceAdapter());
    Hive.registerAdapter(PresenceColorAdapter());
    Hive.registerAdapter(SemesterAdapter());
    Hive.registerAdapter(SemesterListAdapter());
    Hive.registerAdapter(StageCodeAdapter());
    Hive.registerAdapter(TeacherAdapter());
    Hive.registerAdapter(TeachingUnitAdapter());
    Hive.registerAdapter(TeachingUnitListAdapter());
    Hive.registerAdapter(TomussTextAdapter());
    Hive.registerAdapter(UploadAdapter());
    Hive.registerAdapter(URLAdapter());
    Hive.registerAdapter(StudentAdapter());
  }

  Future<ParsedPage?> getParsedPage(final String url,
      {bool autoRefresh = true}) async {
    if (!_authentication.isAuthenticated) return null;

    String content =
        (await _authentication.serviceRequest(url, wrapUrl: false)).body;
    final HTMLparser parser = HTMLparser();

    if (content.length < 1000) {
      final BeautifulSoup bs = BeautifulSoup(content);
      // there is a delay if you refresh tomuss too quicky
      final double delay = double.tryParse(bs.find("#t")?.text ?? "") ?? 15.0;
      if (autoRefresh) {
        return Future.delayed(Duration(seconds: delay.round() + 2),
            () => getParsedPage(url, autoRefresh: false));
      } else {
        return ParsedPage(
            null, null, null, true, Duration(seconds: delay.round() + 2));
      }
    }
    parser.parse(content);

    return ParsedPage(parser.extractStudent(), parser.extractSemesters(),
        parser.extractTeachingUnits(), false, Duration.zero);
  }

  Future<void> logout() async {
    _authentication.logout();
  }

  static String currentSemester() {
    return URLCreator.currentSemester(DateTime.now());
  }

  static String previousSemester() {
    return URLCreator.previousSemester(DateTime.now());
  }
}

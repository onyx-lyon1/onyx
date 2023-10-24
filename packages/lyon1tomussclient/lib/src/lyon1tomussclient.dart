import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:lyon1tomussclient/src/utils/urlcreator.dart';
import 'package:lyon1tomussclient/src/parser/htmlparser.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1casclient/lyon1casclient.dart';

class Lyon1TomussClient {
  final Lyon1CasClient _authentication;

  const Lyon1TomussClient(Lyon1CasClient authentication)
      : _authentication = authentication;

  Lyon1CasClient get lyon1Cas => _authentication;

  Future<ParsedPage?> getParsedPage(final String url,
      {bool autoRefresh = true}) async {
    if (!_authentication.isAuthenticated) return null;

    String content = (await _authentication.serviceRequest(url)).body;
    final HTMLparser parser = HTMLparser();

    if (content.length < 1000) {
      final BeautifulSoup bs = BeautifulSoup(content);
      // there is a delay if you refresh tomuss too quicky
      final double delay = double.tryParse(bs.find("#t")?.text ?? "") ?? 15.0;
      if (autoRefresh) {
        return Future.delayed(Duration(seconds: delay.round() + 2), () async {
          content = (await _authentication.serviceRequest(url)).body;
          if (content.length > 1000) {
            parser.parse(content);
            return ParsedPage(parser.extractSemesters(),
                parser.extractTeachingUnits(), false, Duration.zero);
          } else {
            return null;
          }
        });
      } else {
        return ParsedPage(
            null, null, true, Duration(seconds: delay.round() + 2));
      }
    }
    parser.parse(content);

    return ParsedPage(parser.extractSemesters(), parser.extractTeachingUnits(),
        false, Duration.zero);
  }

  Future<void> logout() async {
    _authentication.logout();
  }

  static Semester currentSemester() {
    String name = URLCreator.currentSemesterName(DateTime.now());
    return Semester(name, URLCreator.semesterFromName(name));
  }

  static Semester previousSemester() {
    String name = URLCreator.previousSemesterName(DateTime.now());
    return Semester(name, URLCreator.semesterFromName(name));
  }
}

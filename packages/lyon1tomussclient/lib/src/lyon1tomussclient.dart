import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1tomussclient/hive/hive_registrar.g.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:lyon1tomussclient/src/parser/htmlparser.dart';
import 'package:lyon1tomussclient/src/utils/urlcreator.dart';

class Lyon1TomussClient {
  final Lyon1CasClient _authentication;

  const Lyon1TomussClient(Lyon1CasClient authentication)
      : _authentication = authentication;

  Lyon1CasClient get lyon1Cas => _authentication;

  static void registerAdapters() {
    Hive.registerAdapters();
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

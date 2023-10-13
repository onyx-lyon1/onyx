import 'package:hive/hive.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1agendaclient/src/constants/constants.dart';
import 'package:lyon1agendaclient/src/model/agenda.dart';
import 'package:lyon1agendaclient/src/parser/agendaparser.dart';
import 'package:lyon1agendaclient/src/utils/agenda_url.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:requests_plus/requests_plus.dart';

class Lyon1AgendaClient {
  late final AgendaParser _parser = AgendaParser();
  late AgendaURL _agendaURL;
  late final String _corsProxyUrl;

  Lyon1AgendaClient(this._agendaURL) {
    _corsProxyUrl = "";
  }

  static void registerAdapters() {
    Hive.registerAdapter(AgendaAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(EventAdapter());
  }

  Lyon1AgendaClient.useLyon1Cas(final Lyon1CasClient authentication) {
    _agendaURL = AgendaURL(authentication);
    _corsProxyUrl = authentication.corsProxyUrl;
  }

  Future<Agenda?> getAgenda({int? id}) async {
    String url = "";
    if (id == null) {
      url = (await _agendaURL.getURL()); //it's everytime 2 for the project id
    } else {
      url = (await _agendaURL.getURL(
          projectid: "3",
          resources: id.toString())); //it's everytime 2 for the project id
    }
    url = url.replaceFirst("http:", "https:"); // force https

    final response = await RequestsPlus.get(
      url,
      headers: {
        'User-Agent': Constants.userAgent,
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate, br',
        'DNT': '1',
        'Pragma': 'no-cache',
        'Cache-Control': 'no-cache'
      },
      corsProxyUrl: _corsProxyUrl,
      timeoutSeconds: 20,
    );
    return ((response.statusCode) >= 400)
        ? null
        : await _parser.parseICS(response.body);
  }
}

import 'dart:convert';

import 'package:hive_ce/hive.dart';
import 'package:lyon1agendaclient/hive/hive_registrar.g.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1agendaclient/src/constants/constants.dart';
import 'package:lyon1agendaclient/src/parser/agendaparser.dart';
import 'package:lyon1agendaclient/src/utils/agenda_url.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:requests_plus/requests_plus.dart';

class Lyon1AgendaClient {
  late final AgendaParser _parser = AgendaParser();
  late AgendaURL _agendaURL;
  late final String _corsProxyUrl;
  late final Lyon1CasClient _casClient;
  String _token = "";

  Lyon1AgendaClient(this._agendaURL, this._casClient) {
    _corsProxyUrl = "";
  }

  static void registerAdapters() {
    Hive.registerAdapters();
  }

  Lyon1AgendaClient.useLyon1Cas(final Lyon1CasClient authentication) {
    _casClient = authentication;
    _agendaURL = AgendaURL();
    _corsProxyUrl = authentication.corsProxyUrl;
  }

  Future<void> login() async {
    // Login through ADE
    await _casClient.serviceRequest(Constants.adeWebURL,
        wrapUrl: true, followRedirects: true, unsafe: false);

    // Request a firsty bearer token
    final resp = await RequestsPlus.post(Constants.adeTokenUrl);
    _token = jsonDecode(resp.body)["token"];

    // Don't know why but we need to get a second one to replace the first token (the first is used to get the second)
    final tokenUpdate = await RequestsPlus.post(Constants.adeAuthUrl,
        headers: buildAuthHeaders(), json: {"name": "", "password": ""});
    _token = jsonDecode(tokenUpdate.body)["data"]["accessToken"];
    if (!(await isLoggedIn())) {
      throw Exception("login failed");
    }
  }

  Future<bool> isLoggedIn() async {
    final check = await RequestsPlus.post(Constants.adeAuthUrl,
        headers: buildAuthHeaders(), json: {"name": "", "password": ""});
    return check.statusCode == 200 &&
        jsonDecode(check.body)["data"]["isAuthenticated"];
  }

  Map<String, String> buildAuthHeaders(
      {Map<String, String> headers = const {}}) {
    final Map<String, String> resultHeaders = Map.from(headers);
    resultHeaders["Authorization"] = "Bearer $_token";
    return resultHeaders;
  }

  Future<List<int>> get getAgendaIds async {
    String resources =
        (await _agendaURL.getUserAgendaIds(_casClient)).resources;
    List<int?> ids = resources.split(",").map((e) => int.tryParse(e)).toList();
    ids.removeWhere((element) => element == null);
    return ids.map((e) => e!).toList();
  }

  Future<Agenda?> getAgenda({required List<int> ids}) async {
    assert(ids.isNotEmpty);
    String url = "";
    url = (await _agendaURL.getURL(_casClient,
        projectid: Constants.idProject, resources: ids.join(",")));
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

  Future<List<AgendaResource>> get getResources async {
    final resp = await RequestsPlus.get(Constants.adeResourcesUrl,
        queryParameters: {"idProject": Constants.idProject},
        headers: buildAuthHeaders(headers: {
          "charset": "utf-8",
        }));
    final data = jsonDecode(utf8.decode(resp.bodyBytes));
    List<AgendaResource> resource = [];
    for (var i in data["data"]["category"]) {
      resource.add(AgendaResource.fromJson(i));
    }
    resource.sort((a, b) => a.name.compareTo(b.name));
    return resource;
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart';
import 'package:requests_plus/requests_plus.dart';

import 'constant/constants.dart';
import 'credential.dart';

class Lyon1CasClient {
  static String encryptionKeyName = "tgcToken";
  bool isAuthenticated = false;
  late final String _corsProxyUrl;

  String get corsProxyUrl => _corsProxyUrl;

  Lyon1CasClient({String corsProxyUrl = ""}) {
    if (!corsProxyUrl.endsWith("/") &&
        !corsProxyUrl.startsWith("http") &&
        corsProxyUrl.isNotEmpty) {
      throw Exception("proxyUrl must end with / and start with http or https");
    }
    _corsProxyUrl = corsProxyUrl;
  }

  Future<({bool authResult, Credential credential})> authenticate(
      Credential credential,
      {bool cookieOnly = false}) async {
    if (credential.tgcToken.isNotEmpty) {
      CookieJar cookieJar =
          await RequestsPlus.getStoredCookies(Constants.casLogin);
      cookieJar["TGC"] = Cookie("TGC", credential.tgcToken);
      await RequestsPlus.setStoredCookies(Constants.casLogin, cookieJar);
    }
    if (cookieOnly) {
      return (credential: credential, authResult: await checkAuthentificated());
    }
    if (!(await checkAuthentificated())) {
      await RequestsPlus.clearStoredCookies(Constants.casLogin);
      isAuthenticated =
          await _authenticationRequest(await getExecToken(), credential);
    } else {
      isAuthenticated = true;
    }
    credential = credential.copyWith(tgcToken: (await getTgcToken()) ?? "");
    return (credential: credential, authResult: isAuthenticated);
  }

  Future<void> logout() async {
    await RequestsPlus.get(
      Constants.casLogout,
      corsProxyUrl: _corsProxyUrl,
      withCredentials: true,
    );
    await RequestsPlus.clearStoredCookies(Constants.casLogin);
    isAuthenticated = false;
  }

  Future<Response> serviceRequest(String url,
      {bool unsafe = true,
      bool wrapUrl = true,
      bool followRedirects = true}) async {
    if (wrapUrl) {
      url = "${Constants.casLogin}?service=$url${(unsafe ? '/?unsafe=1' : '')}";
    }
    final response = await RequestsPlus.get(
      url,
      corsProxyUrl: _corsProxyUrl,
      headers: {
        'User-Agent': Constants.userAgent,
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
        'DNT': '1', // Do Not Track, because, why not
      },
      followRedirects: followRedirects,
      withCredentials: true,
    );

    if ((response.statusCode) >= 400) {
      throw "Failed to fetch the page: ${response.statusCode}";
    }

    return response;
  }

  Future<String> getExecToken() async {
    // perform the request and check the status code
    final response = await RequestsPlus.get(
      Constants.casLogin,
      corsProxyUrl: _corsProxyUrl,
      headers: {
        'User-Agent': Constants.userAgent,
      },
      withCredentials: true,
    );

    if ((response.statusCode) >= 400) {
      throw "Failed: ${response.statusCode}";
    }

    // extract the exec token from the html
    final BeautifulSoup bs = BeautifulSoup(response.body);
    final String execToken =
        bs.find('*', attrs: {'name': 'execution'})?.attributes['value'] ?? "";

    return execToken;
  }

  Future<bool> _authenticationRequest(
      final String execToken, Credential credential) async {
    final response = await RequestsPlus.post(
      Constants.casLogin,
      corsProxyUrl: _corsProxyUrl,
      body: {
        'username': credential.username,
        'password': credential.password,
        'lt': '',
        'execution': execToken,
        '_eventId': 'submit',
        'submit': 'SE+CONNECTER'
      },
      headers: {
        'User-Agent': Constants.userAgent,
        'DNT': '1', // Do Not Track, because, why not
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      withCredentials: true,
    );
    if ((response.statusCode) >= 400) {
      return false;
    }

    String casCookies = await getCasCookies();
    return casCookies.isNotEmpty && casCookies.contains("TGC=");
  }

  Future<String?> getTgcToken() async {
    final String casCookies = await getCasCookies();
    if (casCookies.isNotEmpty && casCookies.contains("TGC=")) {
      return casCookies.split("TGC=")[1].split(";")[0];
    }
    return null;
  }

  Future<String> getCasCookies() async {
    String cookiesString = "";
    final List<Cookie> cookies =
        (await RequestsPlus.getStoredCookies(Constants.casLogin))
            .values
            .toList();

    for (final Cookie cookie in cookies) {
      cookiesString += "${cookie.name}=${cookie.value}; ";
    }

    return cookiesString.length > 2
        ? cookiesString.substring(0, cookiesString.length - 2)
        : "";
  }

  Future<bool> checkAuthentificated() async {
    final response = await RequestsPlus.get(
      Constants.casLogin,
      corsProxyUrl: _corsProxyUrl,
      headers: {
        'User-Agent': Constants.userAgent,
        // 'cookie': await getCasCookies(),
        'DNT': '1', // Do Not Track, because, why not
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      withCredentials: true,
    );
    if (response.statusCode == 200 &&
        response.body.contains("Connexion réussie")) {
      return true;
    }
    return false;
  }
}

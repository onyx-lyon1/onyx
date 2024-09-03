// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:requests_plus/requests_plus.dart';

import 'constant/constants.dart';
import 'credential.dart';

class Lyon1CasClient {
  static String encryptionKeyName = "tgcToken";
  bool isAuthenticated = false;
  late final String _corsProxyUrl;

  static void registerAdapters({bool initHive = true}) {
    Hive.registerAdapter(CredentialAdapter());
    if (initHive) Hive.init(Directory.current.path);
  }

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
    credential = credential.copyWith.tgcToken((await getTgcToken()));
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

  Future<Response> serviceRequest(
    String url, {
    bool unsafe = true,
    bool wrapUrl = true,
    bool followRedirects = true,
    int maxRetry = 5,
  }) async {
    if (wrapUrl) {
      url = "${Constants.casLogin}?service=$url${(unsafe ? '/?unsafe=1' : '')}";
    }
    Response? response;
    for (var i = 0;
        i < maxRetry && (response?.request?.url.host.contains("cas") ?? true);
        i++) {
      if (response != null) {
        url = response.request!.url.toString();
      }
      response = await RequestsPlus.get(
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
    }
    if ((response!.statusCode) >= 400) {
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

    try {
      await getTgcToken(); // getCasCookie throw a null error if theres no auth cookie
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getTgcToken() async {
    final data = (await RequestsPlus.getStoredCookies(Constants.casLogin));
    return data.delegate["TGC-CAS"]!.value;
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
    return response.statusCode == 200 &&
        response.body.contains("Log In Successful");
  }
}

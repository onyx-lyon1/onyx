import 'dart:convert';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:requests_plus/requests_plus.dart';

class IzlyClient {
  static const _baseUrl = 'https://mon-espace.izly.fr';
  static const _menuUrl =
      "http://webservices-v2.crous-mobile.fr:8080/feed/lyon/externe/crous-lyon.json";
  late final String _corsProxyUrl;

  static void registerAdapters() {
    Hive.registerAdapter(IzlyCredentialAdapter());
    Hive.registerAdapter(IzlyQrCodeAdapter());
    Hive.registerAdapter(IzlyQrCodeListAdapter());
    Hive.registerAdapter(MenuTypeAdapter());
    Hive.registerAdapter(MenuRegimeAdapter());
    Hive.registerAdapter(MenuCrousTypeAdapter());
    Hive.registerAdapter(PlatCrousAdapter());
    Hive.registerAdapter(MenuCrousAdapter());
    Hive.registerAdapter(CrousTypeAdapter());
    Hive.registerAdapter(RestaurantModelAdapter());
    Hive.registerAdapter(RestaurantListModelAdapter());
  }

  final String _username;
  final String _password;
  bool _isLogged = false;

  IzlyClient(this._username, this._password, {String corsProxyUrl = ""}) {
    if (!corsProxyUrl.endsWith("/") && corsProxyUrl.isNotEmpty) {
      throw Exception("proxyUrl must end with /");
    }
    _corsProxyUrl = corsProxyUrl;
  }

  Future<bool> isLogged() async {
    final r = await RequestsPlus.get("$_baseUrl/Home/PaymentInitiation",
        corsProxyUrl: _corsProxyUrl);
    return (r.statusCode == 200);
  }

  Future<bool> login() async {
    var r = await RequestsPlus.get("$_baseUrl/Home/Logon",
        corsProxyUrl: _corsProxyUrl);
    List<String> content = r
        .content()
        .split("\n")
        .firstWhere((element) => element.contains("__RequestVerificationToken"))
        .split('"');
    int index = content.indexOf(" value=");
    // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
    String __RequestVerificationToken = content[index + 1];
    r = await RequestsPlus.post('$_baseUrl/Home/Logon',
        body: {
          'Username': _username,
          'Password': _password,
          'ReturnUrl': '/',
          "__RequestVerificationToken": __RequestVerificationToken,
        },
        corsProxyUrl: _corsProxyUrl,
        followRedirects: false);
    if (r.statusCode != 302) {
      throw Exception("Login failed");
    }
    _isLogged = true;
    return true;
  }

  Future<void> logout() async {
    var r = await RequestsPlus.get("$_baseUrl/Home/Logout",
        corsProxyUrl: _corsProxyUrl);
    if (r.statusCode != 200) {
      throw Exception("Logout failed");
    }
    _isLogged = false;
  }

  Future<double> getBalance() async {
    assert(_isLogged);
    var r = await RequestsPlus.get("$_baseUrl/", corsProxyUrl: _corsProxyUrl);
    if (r.statusCode != 200) {
      throw Exception("GetBalance failed");
    }
    if (r.content().isEmpty) {
      throw Exception("GetBalance failed");
    }
    Document document = parse(r.content());
    //select the value in the p with id balance
    String balance =
        document.getElementById("balance")!.innerHtml.split("<sup>").first;
    return double.parse(balance.replaceAll(",", "."));
  }

  Future<List<Uint8List>> getNQRCode(int n) async {
    assert(_isLogged);
    assert(n < 4);
    var r = await RequestsPlus.post("$_baseUrl/Home/CreateQrCodeImg",
        body: {
          'nbrOfQrCode': n.toString(),
        },
        corsProxyUrl: _corsProxyUrl);
    List<Uint8List> result = [];
    for (var i in jsonDecode(r.body)) {
      result.add(base64Decode(i['Src'].split("base64,").last));
    }
    return result;
  }

  Future<({Map<String, dynamic> body, String url})> getTransferPaymentUrl(
      double amount) async {
    assert(_isLogged);
    var r = await RequestsPlus.post(
        "$_baseUrl/Home/PaymentInitiationRequest?amount=${amount.toStringAsFixed(2)}",
        corsProxyUrl: _corsProxyUrl);
    if (r.statusCode != 200) {
      throw Exception("Payment failed");
    }
    return (
      url: jsonDecode(r.content())["url"].toString(),
      body: <String, dynamic>{}
    );
  }

  Future<List<CbModel>> getAvailableCBs() async {
    var r = await RequestsPlus.get("$_baseUrl/Home/Recharge",
        corsProxyUrl: _corsProxyUrl);
    if (r.statusCode != 200) {
      throw Exception("Recharge failed");
    }
    Document document = parse(r.content());
    final List<Element> cbName = document
        .getElementsByClassName("customSelect wLarg form-control")
        .first
        .children;
    List<CbModel> cb = [];
    for (var i in cbName) {
      cb.add(CbModel(i.innerHtml, i.attributes['value']!));
    }
    return cb;
  }

  Future<({Map<String, dynamic> body, String url})> rechargeWithCB(
      double amount, CbModel cb) async {
    assert(amount >= 10.0);

    if ((cb.id != "newCB")) {
      var r = await RequestsPlus.post("$_baseUrl/Home/RechargeConfirm",
          body: {
            'dataToSend':
                '{"Amount":"${amount.toStringAsFixed(2)}","Code":"$_password","Senders":[{"ID":"${cb.id}","Name":"${cb.name}","Amount":"${amount.toStringAsFixed(2)}"}]}',
            'operation': '',
            'engagementId': '',
          },
          corsProxyUrl: _corsProxyUrl);
      if (r.statusCode != 200) {
        throw Exception("Recharge failed");
      }
      final jsonData = jsonDecode(r.body);
      final securityReturn =
          jsonDecode(jsonData["Confirm"]["DalenysData3DSReturn"]);
      return (
        url: jsonData["Confirm"]["DalenysUrl3DSReturn"].toString(),
        body: {
          'transaction_id': securityReturn['transaction_id'],
          'transaction_public_id': securityReturn['transaction_public_id'],
          'card_network': securityReturn['card_network'],
          'log_id': securityReturn['log_id'],
        }
      );
    } else {
      var r = await RequestsPlus.post("$_baseUrl/Home/PaymentCreateRequest",
          body: {
            'amount': amount.toStringAsFixed(2),
          },
          corsProxyUrl: _corsProxyUrl);
      if (r.hasError) {
        throw 'web error';
      }
      r = await RequestsPlus.post("$_baseUrl/Profile/CompleteProfilePayment",
          body: {
            'amount': jsonDecode(r.body)["amount"],
            'registered': "true",
            'transferId': jsonDecode(r.body)["transfertId"]
          },
          corsProxyUrl: _corsProxyUrl);
      if (r.hasError) {
        throw 'web error';
      }
      Document parsedHtml = HtmlParser(r.body).parse();
      Map<String, dynamic> body = {};
      for (Node node in parsedHtml.children.first.nodes[2].nodes[1].nodes
          .firstWhere(
              (element) => element.attributes["id"] == "submit-payment-form")
          .nodes
          .toList()) {
        if (node.attributes.containsKey("type") &&
            node.attributes["type"] == "hidden") {
          body[node.attributes['name'].toString()] = node.attributes['value'];
        }
      }
      return (
        url: "https://secure-magenta1.be2bill.com/front/form/process",
        body: body
      );
    }
  }

  Future<bool> rechargeViaSomeoneElse(
      double amount, String email, String message) async {
    assert(_isLogged);
    assert(amount >= 10.0);
    var r =
        await RequestsPlus.post("$_baseUrl/PayInRequest/PayInRequestConfirm",
            body: {
              "Email": email,
              "AmountPad.AmountSelectedValue": "",
              "Message": message,
              "PadAmount": "0",
              "Amount": amount.toStringAsFixed(2),
            },
            corsProxyUrl: _corsProxyUrl);
    if (r.statusCode != 200) {
      throw Exception("Recharge failed");
    }
    return true;
  }

  static Future<List<RestaurantModel>> getRestaurantCrous() async {
    final r = await RequestsPlus.get(_menuUrl,
        bodyEncoding: RequestBodyEncoding.JSON);
    if (r.statusCode != 200) {
      throw Exception("Can't get menu crous");
    }
    String body =
        r.body.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
    final decoded = jsonDecode(utf8.decode(body.codeUnits));
    return (decoded["restaurants"] as List)
        .map((e) => RestaurantModel.fromJson(e))
        .toList();
  }
}

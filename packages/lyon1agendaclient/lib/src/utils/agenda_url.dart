import 'package:lyon1casclient/lyon1casclient.dart';

class AgendaURL {
  AgendaURL();

  Future<String> getURL(Lyon1CasClient auth,
      {int days = 180, String? resources, int? projectid}) async {
    final DateTime start = DateTime.now().add(Duration(days: -180));
    final DateTime end = DateTime.now().add(Duration(days: 180));
    return getURLForDates(start, end, auth,
        resources_: resources, projectid_: projectid);
  }

  Future<String> getURLForDates(
      final DateTime start, final DateTime end, final Lyon1CasClient auth,
      {String? resources_, int? projectid_}) async {
    if (resources_ == null || projectid_ == null) {
      final ids = await getUserAgendaIds(auth);
      resources_ = ids.resources;
      projectid_ = ids.projectid;
    }
    return await _getIcalURL(
        resources_, projectid_, _convertDate(start), _convertDate(end));
  }

  Future<String> _getIcalURL(final String resources, final int projectid,
      final String start, final String end) async {
    return "https://edt.univ-lyon1.fr/jsp/custom/modules/plannings/anonymous_cal.jsp?resources=$resources&projectId=$projectid&calType=ical&firstDate=$start&lastDate=$end";
  }

  Future<({String resources, int projectid})> getUserAgendaIds(
      Lyon1CasClient auth) async {
    if (!auth.isAuthenticated) {
      throw Exception("unAuthenticated");
    }
    try {
      await auth.serviceRequest(
          "https://sciences-licence.univ-lyon1.fr/outils/emploi-du-temps/",
          wrapUrl: false,
          followRedirects: false);

      final response2 = await auth.serviceRequest(
          "https://sciences-licence.univ-lyon1.fr/servlet/com.jsbsoft.jtf.core.SG?PROC=IDENTIFICATION_FRONT",
          wrapUrl: true,
          unsafe: false,
          followRedirects: false);

      final response3 = await auth.serviceRequest(
          response2.headers["location"]!,
          wrapUrl: false,
          followRedirects: false);

      final Uri uri = Uri.parse(response3.headers["location"]!)
          .replace(path: "/outils/emploi-du-temps");
      final response4 = await auth.serviceRequest(uri.toString(),
          wrapUrl: false, followRedirects: false);
      final finalResponseString = response4.body;

      // with regex select the first ressource like this resources=88773,31561,92543,94029,49637
      final RegExpMatch? match =
          RegExp(r"resources=(\d+,?)+").firstMatch(finalResponseString);
      final String resources = match!.group(0)!.split("=")[1];
      // with regex select the first projectid like this projectid=2
      final RegExpMatch? match2 =
          RegExp(r"projectId=\d+").firstMatch(finalResponseString);
      final int projectid = int.parse(match2!.group(0)!.split("=")[1]);

      return (resources: resources, projectid: projectid);
    } catch (e) {
      throw AutoIdException("unable to get ids");
    }
  }

  String _convertDate(final DateTime dt) {
    return dt.toIso8601String().split("T")[0];
  }
}

class AutoIdException implements Exception {
  final String message;

  AutoIdException(this.message);
}

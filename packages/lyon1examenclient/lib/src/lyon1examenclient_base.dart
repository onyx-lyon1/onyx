import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';

class Lyon1ExamenClient {
  static const String examensUrl =
      "https://sciences-licence.univ-lyon1.fr/examens/convocation/mes-examens";
  final Lyon1CasClient _authentication;

  const Lyon1ExamenClient(Lyon1CasClient authentication)
      : _authentication = authentication;

  Future<List<ExamenModel>> fetchExams() async {
    final resp = (await _authentication.serviceRequest(examensUrl));
    final body = resp.body;
    final soup = BeautifulSoup(body);
    final convocSoup = soup.find("form", attrs: {
      'action':
          "https://sciences-licence.univ-lyon1.fr/servlet/com.jsbsoft.jtf.core.SG"
    })!;

    // parsing <b>Analyse 3 Cursus Prépa</b>&nbsp;(<span id="target_examen1">MAT2085L-P3</span>)<br><u>lundi 18/12/2023</u> à <u>14h00</u> - durée : 120 mn<br> Lieu : Amphi Jussieu - Place nº 0750<br><span id="target_presence_examen1"></span></li><li><b>Algorithmique, Programmation Et Structures De Données</b>&nbsp;(
    final spanList = convocSoup
        .findAll("span")
        .where((element) => RegExp(r'target_examen\d+').hasMatch(element.id))
        .toList();
    List<ExamenModel> retour = [];
    for (var i in spanList) {
      final title = i.findPreviousElement("b")?.text;
      final codeName = i.text;
      final dateElements = i.findAllNextElements("u");
      final rawDate = dateElements.map((e) => e.text).toList().join(" ");
      final splitedDate =
          RegExp(r'.*(\w+) (\d{1,2})/(\d{1,2})/(\d{2,4}) (\d{1,2})h(\d{1,2}).*')
              .firstMatch(rawDate)!;
      final year = splitedDate.group(4) != null
          ? int.parse(splitedDate.group(4)!)
          : null;
      final month = splitedDate.group(3) != null
          ? int.parse(splitedDate.group(3)!)
          : null;
      final day = splitedDate.group(2) != null
          ? int.parse(splitedDate.group(2)!)
          : null;
      final hour = splitedDate.group(5) != null
          ? int.parse(splitedDate.group(5)!)
          : null;
      final minute = splitedDate.group(6) != null
          ? int.parse(splitedDate.group(6)!)
          : null;
      final date = (year != null &&
              month != null &&
              day != null &&
              hour != null &&
              minute != null)
          ? DateTime(year, month, day, hour, minute)
          : null;

      //assume the duration is everytime in minute and entire
      final durationMatch = dateElements.last.nextParsedAll[1].text != null
          ? RegExp(r'\d+').stringMatch(dateElements.last.nextParsedAll[1].text!)
          : null;
      final duration = (durationMatch != null)
          ? Duration(minutes: int.parse(durationMatch))
          : null;
      final locationAndPlace = dateElements.last.nextParsedAll[3].text != null
          ? RegExp(r'Lieu : (.+)? - Place n. (\d+)?')
              .firstMatch(dateElements.last.nextParsedAll[3].text ?? "")
          : null;
      final location = locationAndPlace?.group(1);
      final place = locationAndPlace?.group(2) != null
          ? int.parse(locationAndPlace!.group(2)!)
          : null;
      retour.add(ExamenModel(
          title: title,
          codeName: codeName,
          date: date,
          duration: duration,
          location: location,
          place: place));
    }

    return retour;
  }
}

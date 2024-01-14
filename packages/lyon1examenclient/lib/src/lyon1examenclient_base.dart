import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:hive/hive.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:lyon1examenclient/lyon1examenclient.dart';
import 'package:lyon1examenclient/src/duration_adapter.dart';

class Lyon1ExamenClient {
  static const String examensUrl =
      "https://sciences-licence.univ-lyon1.fr/examens/convocation/mes-examens";
  final Lyon1CasClient _authentication;

  const Lyon1ExamenClient(Lyon1CasClient authentication)
      : _authentication = authentication;

  static void registerAdapters() {
    Hive.registerAdapter(ExamenModelAdapter());
    Hive.registerAdapter(ExamenListModelAdapter());
    Hive.registerAdapter(DurationAdapter());
  }

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
      final title = i.findPreviousElement("b")!.text;
      final codeName = i.text;
      final dateElements = i.findAllNextElements("u");
      final rawDate =
          dateElements.map((e) => e.text).toList().sublist(0, 2).join(" ");
      final splitedDate =
          RegExp(r'(\w+) (\d{2})/(\d{2})/(\d{4}) (\d{2})h(\d{2})$')
              .firstMatch(rawDate)!;
      final date = DateTime(
          int.parse(splitedDate.group(4)!),
          int.parse(splitedDate.group(3)!),
          int.parse(splitedDate.group(2)!),
          int.parse(splitedDate.group(5)!),
          int.parse(splitedDate.group(6)!));
      //assume the duration is everytime in minute and entire
      final duration = Duration(
          minutes: int.parse(RegExp(r'\d+')
              .stringMatch(dateElements.last.nextParsedAll[1].text!)!));
      final locationAndPlace = RegExp(r'Lieu : (.+) - Place n. (.+)$')
          .firstMatch(dateElements.last.nextParsedAll[3].text!);
      final location = locationAndPlace!.group(1)!;
      final place = int.parse(locationAndPlace.group(2)!);
      retour.add(ExamenModel(title, codeName, date, duration, location, place));
    }

    return retour;
  }
}

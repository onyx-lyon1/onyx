import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:equatable/equatable.dart';
import 'package:requests_plus/requests_plus.dart';

import 'package:html/dom.dart';

enum Year {
  first,
  second,
}

class PolytechColloscopeClient {
  static const String userAgent =
      "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:96.0) Gecko/20100101 Firefox/96.0";

  // HTTPS parce que le https est pas géré
  static const String _base = "http://math.univ-lyon1.fr/colles/";

  static const kholleURL = {
    Year.first: "$_base?page=colles_1A",
    Year.second: "$_base?page=colles_2A"
  };

  static const khollesStudentURL = {
    Year.first: "$_base?page=colles_1A&id_etudiant=:id",
    Year.second: "$_base?page=colles_2A&id_etudiant=:id"
  };

  static const Map monthsTranslation = {
    "janvier": DateTime.january,
    "février": DateTime.february,
    "mars": DateTime.march,
    "avril": DateTime.april,
    "mai": DateTime.may,
    "juin": DateTime.june,
    "juillet": DateTime.july,
    "août": DateTime.august,
    "septembre": DateTime.september,
    "octobre": DateTime.october,
    "novembre": DateTime.november,
    "décembre": DateTime.december
  };

  final String username, password;
  PolytechColloscopeClient(this.username, this.password);

  Future<List<Student>> fetchStudents(Year year) async {
    var page = await RequestsPlus.get(kholleURL[year]!,
        userName: username, password: password);

    BeautifulSoup bs = BeautifulSoup(page.body);

    //This isolates the student list part of the page, it consists in a list of <li> elements like
    // <li><a href="?page=colles_2A&amp;id_etudiant=STUDENT_ID">INITAL. SUNRNAME</a> (groupe GROUPNUMBER)</li>
    var studentsList = bs.find("table.colles")?.find("td > ul");

    List<Student> students = [];

    studentsList?.findAll("li > a").forEach((e) {
      var name = e.innerHtml;
      var link = e.getAttrValue("href");
      var id = RegExp(r"id_etudiant=(\d+)").firstMatch(link!)?.group(1);

      students.add(Student(name, id!));
    });

    return students;
  }

  Future<StudentColloscope> getColloscope(Year year, int studentId) async {
    // TODO : Add a check to verify the studentid (look 5 lines below)

    var page = await RequestsPlus.get(
        khollesStudentURL[year]!.replaceFirst(":id", studentId.toString()),
        userName: username,
        password: password);

    BeautifulSoup bs = BeautifulSoup(page.body);

    // We can use this to check if the studentid is valid
    var trinomeStr = RegExp(r"trinôme (\d+)")
        .firstMatch(bs.find("h3.colles")!.innerHtml)
        ?.group(1);

    var trinome = int.parse(trinomeStr!);

    var tableHtml = bs.find("table.colles");

    List kholles = [];

    tableHtml?.findAll("tr").forEach((e) {
      kholles.add(parseKholle(e));
    });

    return StudentColloscope(studentId, trinome, kholles);
  }

  static Kholle parseKholle(Bs4Element e) {
    // Gathering data from html (this parsing is awful but can't really do better)

    var date = e.children.first.innerHtml.trim();
    var secondTd = e.children.elementAtOrNull(1);

    var hourAndMinute =
    secondTd?.children.first.innerHtml.replaceFirst("&nbsp;", "").trim();

    var secondDiv = secondTd?.children.elementAtOrNull(1);
    var kholleur = secondDiv?.find("a")?.text.trim();

    // This hold the subject of the kholle (and maybe the room because this website html is probably the worst I've ever seen)
    var text = "";

    var divText = secondDiv?.nodes.where((element) => element.runtimeType == Text);

    var subject = divText?.first.text?.replaceAll(RegExp(r'[()]'), "").trim();

    String message;
    if (divText?.length == 2) {
      message = divText?.last.text?.replaceAll(RegExp(r'[()]'), "").trim() ?? "";
    } else {
      message = "";
    }

    var dateParsed = RegExp(r"(\d{1,2}) (.{3,9})").firstMatch(date);
    var day = dateParsed?.group(1);
    var month = monthsTranslation[dateParsed?.group(2)];

    var hourAndMinutesParsed =
    RegExp(r"(\d{1,2}) h (\d{2})").firstMatch(hourAndMinute!);
    var hour = hourAndMinutesParsed?.group(1);
    var minutes = hourAndMinutesParsed?.group(2);

    var dateTime = DateTime(DateTime.now().year, month, int.parse(day!),
        int.parse(hour!), int.parse(minutes!));

    return Kholle(dateTime, subject!, message, kholleur);
  }
}

class Student extends Equatable {
  final String name;
  final String id;

  Student(this.name, this.id);

  @override
  List<Object?> get props => [name, id];

  @override
  bool? get stringify => true;
}

class StudentColloscope extends Equatable {
  final int studentId;
  final int trinomeId;
  final List kholles;

  StudentColloscope(this.studentId, this.trinomeId, this.kholles);

  @override
  List<Object?> get props => [studentId, trinomeId, kholles];

  @override
  bool? get stringify => true;
}

class Kholle extends Equatable {
  final DateTime date;
  final String subject;
  final String? message;
  final String? kholleur;

  Kholle(this.date, this.subject, this.message, this.kholleur);

  @override
  List<Object?> get props => [date, subject, message, kholleur];

  @override
  bool? get stringify => true;
}

Future<void> main() async {
  PolytechColloscopeClient client = PolytechColloscopeClient("", "");

  var students = await client.fetchStudents(Year.first);
  print(students);

  var colloscope = await client.getColloscope(Year.first, 828);
  print(colloscope);
}

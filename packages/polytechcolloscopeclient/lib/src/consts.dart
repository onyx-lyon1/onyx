import 'models/year.dart';

class Consts {
  // HTTPS because the website is not available in HTTP
  static const String _base = "http://math.univ-lyon1.fr/colles/";

  static const kholleURL = {
    Year.first: "$_base?page=colles_1A",
    Year.second: "$_base?page=colles_2A"
  };

  static const khollesStudentURL = {
    Year.first: "$_base?page=colles_1A&id_etudiant=:id",
    Year.second: "$_base?page=colles_2A&id_etudiant=:id"
  };
}

extension MonthsTranslation on String {
  int get asMonthNumber {
    switch (this) {
      case "janvier":
        return DateTime.january;
      case "février":
        return DateTime.february;
      case "mars":
        return DateTime.march;
      case "avril":
        return DateTime.april;
      case "mai":
        return DateTime.may;
      case "juin":
        return DateTime.june;
      case "juillet":
        return DateTime.july;
      case "août":
        return DateTime.august;
      case "septembre":
        return DateTime.september;
      case "octobre":
        return DateTime.october;
      case "novembre":
        return DateTime.november;
      case "décembre":
        return DateTime.december;
      default:
        throw StateError("Invalid month");
    }
  }
}

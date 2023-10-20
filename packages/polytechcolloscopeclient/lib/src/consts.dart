enum Year {
  first,
  second,
}

class Consts {
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
}

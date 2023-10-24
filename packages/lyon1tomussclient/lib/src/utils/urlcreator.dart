import 'package:lyon1tomussclient/src/constant/constants.dart';

class URLCreator {
  static String basic() {
    return Constants.tomuss;
  }

  static String previousSemesterName(final DateTime dt) {
    final String currentSemester =
        (dt.month >= 1 && dt.month < 9) ? "Printemps" : "Automne";

    final String prevSemester =
        (currentSemester == 'Printemps') ? 'Automne' : 'Printemps';

    final int prevYear =
        (currentSemester == 'Printemps') ? dt.year - 1 : dt.year;

    return "$prevYear/$prevSemester";
  }

  static String currentSemesterName(final DateTime dt) {
    final String semester =
        (dt.month >= 1 && dt.month < 9) ? "Printemps" : "Automne";
    return "${dt.year}/$semester";
  }

  static String semesterFromName(final String name) {
    return "${Constants.tomuss}/S/$name";
  }
}

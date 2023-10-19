import 'package:lyon1tomussclient/src/constant/constants.dart';

class URLCreator {
  static String basic() {
    return Constants.tomuss;
  }

  static String previousSemester(final DateTime dt) {
    final String currentSemester =
        (dt.month >= 1 && dt.month < 9) ? "Printemps" : "Automne";

    final String prevSemester =
        (currentSemester == 'Printemps') ? 'Automne' : 'Printemps';

    final int prevYear =
        (currentSemester == 'Printemps') ? dt.year - 1 : dt.year;

    return "${Constants.tomuss}/S/$prevYear/$prevSemester";
  }

  static String currentSemester(final DateTime dt) {
    final String semester =
        (dt.month >= 1 && dt.month < 9) ? "Printemps" : "Automne";
    return "${Constants.tomuss}/S/${dt.year}/$semester";
  }
}

import 'package:onyx/core/extensions/extensions_export.dart';

extension DateExtension on DateTime {
  DateTime shrink(int precision) {
    switch (precision) {
      case 1:
        return DateTime(year);
      case 2:
        return DateTime(year, month);
      case 3:
        return DateTime(year, month, day);
      case 4:
        return DateTime(year, month, day, hour);
      case 5:
        return DateTime(year, month, day, hour, minute);
      case 6:
        return DateTime(year, month, day, hour, minute, second);
      case 7:
        return DateTime(year, month, day, hour, minute, second, millisecond);
      case 8:
        return DateTime(
            year, month, day, hour, minute, second, millisecond, microsecond);
      default:
        return this;
    }
  }

  String dateBeautifull() {
    return "${toWeekDayName(short: false)} ${day.toFixedLengthString(2)}/${month.toFixedLengthString(2)}/${year.toFixedLengthString(4)}";
  }

  String toWeekDayName({bool short = false}) {
    switch (weekday) {
      case 1:
        return short ? "Lun." : "Lundi";
      case 2:
        return short ? "Mar." : "Mardi";
      case 3:
        return short ? "Mer." : "Mercredi";
      case 4:
        return short ? "Jeu." : "Jeudi";
      case 5:
        return short ? "Ven." : "Vendredi";
      case 6:
        return short ? "Sam." : "Samedi";
      case 7:
        return short ? "Dim." : "Dimanche";
      default:
        return "Erreur";
    }
  }

  String toMonthName({bool short = false}) {
    switch (month) {
      case 1:
        return short ? "Janv." : "Janvier";
      case 2:
        return short ? "Févr." : "Février";
      case 3:
        return short ? "Mars." : "Mars";
      case 4:
        return short ? "Avril" : "Avril";
      case 5:
        return short ? "Mai" : "Mai";
      case 6:
        return short ? "Juin" : "Juin";
      case 7:
        return short ? "Juil." : "Juillet";
      case 8:
        return short ? "Août" : "Août";
      case 9:
        return short ? "Sept." : "Septembre";
      case 10:
        return short ? "Oct." : "Octobre";
      case 11:
        return short ? "Nov." : "Novembre";
      case 12:
        return short ? "Déc." : "Décembre";
      default:
        return "Erreur";
    }
  }

  int toWeekNumber() {
    return ((difference(DateTime(year, 1, 1)).inDays) / 7).ceil();
  }
}
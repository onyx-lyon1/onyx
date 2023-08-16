extension MonthName on DateTime{
  String toMonthName({bool short=false}) {
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
}
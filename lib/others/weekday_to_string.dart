String weekdayToString(int weekDay, {bool short=false}){
  switch(weekDay){
    case 1:
      return short?"Lun.":"Lundi";
    case 2:
      return short?"Mar.":"Mardi";
    case 3:
      return short?"Mer.":"Mercredi";
    case 4:
      return short?"Jeu.":"Jeudi";
    case 5:
      return short?"Ven.":"Vendredi";
    case 6:
      return short?"Sam.":"Samedi";
    case 7:
      return short?"Dim.":"Dimanche";
    default:
      return "Erreur";
  }
}

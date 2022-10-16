extension DateBeautifull on Duration {
  String dateBeautifull() {
    int hour = inHours;
    int minute = inMinutes - hour * 60;
    String hourString = hour.toString();
    String minuteString = minute.toString();
    if (hour < 10) {
      hourString = "0$hourString";
    }
    if (minute < 10) {
      minuteString = "0$minuteString";
    }
    return "$hourString:$minuteString";
  }
}

extension DateParser on String {
  DateTime? toDateTime() {
    if (length == 14) {
      return DateTime(
        int.parse(substring(0, 4)),
        int.parse(substring(4, 6)),
        int.parse(substring(6, 8)),
        int.parse(substring(8, 10)),
        int.parse(substring(10, 12)),
        int.parse(substring(12, 14)),
      );
    } else if (length == 8) {
      return DateTime(
        int.parse(substring(0, 4)),
        int.parse(substring(4, 6)),
        int.parse(substring(6, 8)),
      );
    }
    return null;
  }
}

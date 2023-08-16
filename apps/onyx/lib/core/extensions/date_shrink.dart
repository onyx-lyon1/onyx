extension ShrinkDate on DateTime {
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
}

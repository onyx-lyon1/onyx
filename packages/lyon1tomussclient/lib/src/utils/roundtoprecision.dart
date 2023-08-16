class Round {
  static double round(final double? n, {int precision = 3}) {
    return double.tryParse(n?.toStringAsFixed(precision) ?? "") ?? double.nan;
  }
}

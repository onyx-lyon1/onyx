extension Round on double? {
  double roundToPrecision({int precision = 3}) {
    return double.tryParse(this?.toStringAsFixed(precision) ?? "") ??
        double.nan;
  }
}

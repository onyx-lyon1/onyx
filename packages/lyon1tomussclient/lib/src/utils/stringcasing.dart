extension Capitalize on String {
  String get capitalize {
    return isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

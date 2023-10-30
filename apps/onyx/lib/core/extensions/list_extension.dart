extension ListExtension<T> on List<T> {
  T get(int? index, var defaultValue) {
    if (index != null && isNotEmpty && length > index) {
      return this[index];
    }
    return defaultValue;
  }

  int? indexWhereOrNull(bool Function(T) test, [int start = 0]) {
    if (start < 0) start = 0;
    for (int i = start; i < length; i++) {
      if (test(this[i])) return i;
    }
    return null;
  }
}

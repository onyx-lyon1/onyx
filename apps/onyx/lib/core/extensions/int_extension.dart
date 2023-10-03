extension IntExtension on int {
  String toFixedLengthString(int length) {
    return toString().padLeft(length - toString().length + 1, '0');
  }

  int positiveModulo(int divisor) {
    int result = this % divisor;
    return result < 0 ? result + divisor : result;
  }
}

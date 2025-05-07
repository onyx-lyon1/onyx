import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true, bool outputAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${outputAlpha ? a.floor().toRadixString(16).padLeft(2, '0') : ''}'
      '${r.floor().toRadixString(16).padLeft(2, '0')}'
      '${g.floor().toRadixString(16).padLeft(2, '0')}'
      '${b.floor().toRadixString(16).padLeft(2, '0')}';
}

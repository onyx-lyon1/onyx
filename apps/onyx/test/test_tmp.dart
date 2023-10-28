import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:izlyclient/izlyclient.dart';

void main() {
  test("test", () {
    List<IzlyQrCode> list = [];
    list.add(IzlyQrCode(
        qrCode: Uint8List.fromList([1, 2, 3, 4, 5]),
        expirationDate: DateTime.now()));
    list.add(IzlyQrCode(
        qrCode: Uint8List.fromList([1, 2, 3, 4, 5]),
        expirationDate: DateTime.now()));
    print(jsonEncode(list));
    print(jsonDecode(jsonEncode(list)));
  });
}

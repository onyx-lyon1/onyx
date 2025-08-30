import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';

part 'generated/izly_qrcode.mapper.dart';

@MappableClass()
class IzlyQrCode with IzlyQrCodeMappable {
  final Uint8List qrCode;
  final DateTime expirationDate;

  IzlyQrCode({required this.qrCode, required this.expirationDate});
}

import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'izly_qrcode_model.g.dart';

@HiveType(typeId: 16)
class IzlyQrCodeModel{
  @HiveField(0)
  Uint8List qrCode;
  @HiveField(1)
  DateTime expirationDate;

  IzlyQrCodeModel({required this.qrCode, required this.expirationDate});

  @override
  String toString() {
    return 'IzlyQrCodeModel{qrCode: $qrCode, expirationDate: $expirationDate}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyQrCodeModel &&
          runtimeType == other.runtimeType &&
          qrCode == other.qrCode &&
          expirationDate == other.expirationDate;

  @override
  int get hashCode => qrCode.hashCode ^ expirationDate.hashCode;
}
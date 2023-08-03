import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/izly_qrcode.g.dart';

@CopyWith()
@HiveType(typeId: 16)
class IzlyQrCode extends Equatable {
  @HiveField(0)
  final Uint8List qrCode;
  @HiveField(1)
  final DateTime expirationDate;

  IzlyQrCode({required this.qrCode, required this.expirationDate});

  @override
  List<Object?> get props => [qrCode, expirationDate];
  @override
  bool get stringify => true;
}

import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'generated/izly_qrcode.g.dart';

@CopyWith()
class IzlyQrCode extends Equatable {
  final Uint8List qrCode;
  final DateTime expirationDate;

  IzlyQrCode({required this.qrCode, required this.expirationDate});

  @override
  List<Object?> get props => [qrCode, expirationDate];
  @override
  bool get stringify => true;
}

import 'dart:typed_data';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:izlyclient/src/model/uint8list_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/izly_qrcode.g.dart';

@JsonSerializable()
@CopyWith()
class IzlyQrCode extends Equatable {
  @Uint8ListConverter()
  final Uint8List qrCode;
  final DateTime expirationDate;

  IzlyQrCode({required this.qrCode, required this.expirationDate});

  @override
  List<Object?> get props => [qrCode, expirationDate];

  @override
  bool get stringify => true;
}

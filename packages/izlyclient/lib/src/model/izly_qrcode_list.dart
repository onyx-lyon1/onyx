import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/izly_qrcode_list.g.dart';

@JsonSerializable()
@CopyWith()
class IzlyQrCodeList extends Equatable {
  final List<IzlyQrCode> qrCodes;

  IzlyQrCodeList({required this.qrCodes});

  IzlyQrCodeList copyWith({
    List<IzlyQrCode>? qrCodes,
  }) {
    return IzlyQrCodeList(
      qrCodes: qrCodes ?? this.qrCodes,
    );
  }

  @override
  List<Object?> get props => [qrCodes];

  @override
  bool get stringify => true;
}

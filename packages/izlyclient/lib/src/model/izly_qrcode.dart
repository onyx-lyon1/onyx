import 'package:dart_mappable/dart_mappable.dart';

part 'izly_qrcode.mapper.dart';

@MappableClass()
class IzlyQrCode with IzlyQrCodeMappable {
  final List<int> qrCode;
  final DateTime expirationDate;

  IzlyQrCode({required this.qrCode, required this.expirationDate});
}

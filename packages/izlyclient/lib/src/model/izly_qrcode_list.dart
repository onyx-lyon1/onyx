import 'package:dart_mappable/dart_mappable.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/izly_qrcode_list.mapper.dart';

@MappableClass()
class IzlyQrCodeList with IzlyQrCodeListMappable {
  final List<IzlyQrCode> qrCodes;

  IzlyQrCodeList({required this.qrCodes});
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/izly/izly_export.dart';

part 'izly_qrcode_model_wrapper.g.dart';

@HiveType(typeId: 16)
class IzlyQrCodeModelWrapper{
  @HiveField(0)
  List<IzlyQrCodeModel> qrCodes;

  IzlyQrCodeModelWrapper({required this.qrCodes});

  @override
  String toString() {
    return 'IzlyQrCodeModelWrapper{qrCodes: $qrCodes}';
  }
}
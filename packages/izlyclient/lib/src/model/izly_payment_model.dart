import 'package:dart_mappable/dart_mappable.dart';

part 'generated/izly_payment_model.mapper.dart';

@MappableClass()
class IzlyPaymentModel with IzlyPaymentModelMappable {
  final DateTime paymentTime;
  final double amountSpent;
  final bool isSucess;

  IzlyPaymentModel({
    required this.paymentTime,
    required this.amountSpent,
    required this.isSucess,
  });
}

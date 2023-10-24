import 'package:dart_mappable/dart_mappable.dart';

part 'izly_payment_model.mapper.dart';

@MappableClass()
class IzlyPaymentModel with IzlyPaymentModelMappable {
  final String paymentTime;
  final String amountSpent;
  final bool isSucess;

  IzlyPaymentModel({
    required this.paymentTime,
    required this.amountSpent,
    required this.isSucess,
  });
}

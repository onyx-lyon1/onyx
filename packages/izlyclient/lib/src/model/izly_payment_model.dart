import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/izly_payment_model.g.dart';

@JsonSerializable()
class IzlyPaymentModel extends Equatable {
  final DateTime paymentTime;
  final double amountSpent;
  final bool isSucess;

  IzlyPaymentModel({
    required this.paymentTime,
    required this.amountSpent,
    required this.isSucess,
  });

  @override
  List<Object> get props => [paymentTime, amountSpent, isSucess];

  @override
  bool get stringify => true;
}

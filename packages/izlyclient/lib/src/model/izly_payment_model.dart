import 'package:equatable/equatable.dart';

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

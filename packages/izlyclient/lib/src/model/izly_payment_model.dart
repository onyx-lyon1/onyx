import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/izly_payment_model.g.dart';

@HiveType(typeId: 40)
class IzlyPaymentModel extends Equatable {
  @HiveField(3)
  final DateTime paymentTime;
  @HiveField(4)
  final double amountSpent;
  @HiveField(2)
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

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/izly_payment_model_list.g.dart';

@CopyWith()
@HiveType(typeId: 41)
class IzlyPaymentModelList extends Equatable {
  @HiveField(0)
  final List<IzlyPaymentModel> payments;

  IzlyPaymentModelList({required this.payments});

  IzlyPaymentModelList copyWith({
    List<IzlyPaymentModel>? payments,
  }) {
    return IzlyPaymentModelList(
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props => [payments];

  @override
  bool get stringify => true;
}

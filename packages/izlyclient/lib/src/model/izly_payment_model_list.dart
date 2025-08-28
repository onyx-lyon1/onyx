import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/izly_payment_model_list.g.dart';

@CopyWith()
class IzlyPaymentModelList extends Equatable {
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

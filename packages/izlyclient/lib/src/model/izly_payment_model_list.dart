import 'package:dart_mappable/dart_mappable.dart';
import 'package:izlyclient/izlyclient.dart';

part 'generated/izly_payment_model_list.mapper.dart';

@MappableClass()
class IzlyPaymentModelList with IzlyPaymentModelListMappable {
  final List<IzlyPaymentModel> payments;

  IzlyPaymentModelList({required this.payments});
}

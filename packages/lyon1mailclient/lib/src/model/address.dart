import 'package:dart_mappable/dart_mappable.dart';

part 'address.mapper.dart';

@MappableClass()
class Address with AddressMappable {
  final String email;
  final String name;

  Address(this.email, this.name);
}

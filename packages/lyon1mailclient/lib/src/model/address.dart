import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String _email;
  final String _name;

  Address(this._email, this._name);

  get email => _email;

  get name => _name;

  @override
  List<Object?> get props => [_email, _name];

  @override
  bool? get stringify => true;
}

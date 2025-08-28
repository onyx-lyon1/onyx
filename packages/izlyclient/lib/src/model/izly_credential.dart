import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'generated/izly_credential.g.dart';

@CopyWith()
@HiveType(typeId: 15)
class IzlyCredential extends Equatable {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;

  IzlyCredential({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
  @override
  bool get stringify => true;
}

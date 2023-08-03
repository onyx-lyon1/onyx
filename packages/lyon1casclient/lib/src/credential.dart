import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'generated/credential.g.dart';

@CopyWith()
@HiveType(typeId: 4)
class Credential extends Equatable {
  @HiveField(0)
  late final String username;
  @HiveField(1)
  late final String password;
  @HiveField(2, defaultValue: "")
  late final String tgcToken;

  Credential(this.username, this.password, {this.tgcToken = ""});

  @override
  List<Object?> get props => [username, password, tgcToken];

  @override
  bool? get stringify => true;
}

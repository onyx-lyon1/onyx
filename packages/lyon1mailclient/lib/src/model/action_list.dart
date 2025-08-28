import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/action_list.g.dart';

@CopyWith()
@HiveType(typeId: 24)
class ActionList extends Equatable {
  @HiveField(0)
  final List<Action> action;

  ActionList({required this.action});

  @override
  List<Object?> get props => [action];

  @override
  bool? get stringify => true;
}

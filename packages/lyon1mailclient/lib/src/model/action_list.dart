import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/action_list.g.dart';

@CopyWith()
class ActionList extends Equatable {
  final List<Action> action;

  ActionList({required this.action});

  @override
  List<Object?> get props => [action];

  @override
  bool? get stringify => true;
}

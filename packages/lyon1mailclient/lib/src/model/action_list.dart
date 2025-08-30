import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/action_list.mapper.dart';

@MappableClass()
class ActionList with ActionListMappable {
  final List<Action> action;

  ActionList({required this.action});
}

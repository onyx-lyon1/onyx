import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/mails/mails_export.dart';

part 'action_model_wrapper.g.dart';

@HiveType(typeId: 24)
class ActionModelWrapper {
  @HiveField(0)
  final List<ActionModel> action;

  ActionModelWrapper({required this.action});
}

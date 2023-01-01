import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/mails/mails_export.dart';

part 'email_model_wrapper.g.dart';

@HiveType(typeId: 6)
class EmailModelWrapper {
  @HiveField(0)
  late List<EmailModel> emailModels;

  EmailModelWrapper(this.emailModels);

  @override
  String toString() {
    return 'EmailModelWrapper{emailModels: $emailModels}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModelWrapper &&
          runtimeType == other.runtimeType &&
          listEquals(emailModels, other.emailModels);

  @override
  int get hashCode => emailModels.hashCode;
}

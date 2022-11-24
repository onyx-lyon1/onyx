import 'package:hive_flutter/hive_flutter.dart';
import 'package:oloid2/screens/mails/mails_export.dart';

part 'email_model_wrapper.g.dart';

@HiveType(typeId: 11)
class EmailModelWrapper {
  @HiveField(0)
  late List<EmailModel> emailModels;

  EmailModelWrapper(this.emailModels);
}

import 'package:hive_flutter/adapters.dart';
import 'package:oloid2/model/mail_model.dart';

part 'email_model_wrapper.g.dart';

@HiveType(typeId: 11)
class EmailModelWrapper {
  @HiveField(0)
  late List<EmailModel> emailModels;

  EmailModelWrapper(this.emailModels);
}

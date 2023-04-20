import 'package:hive_flutter/hive_flutter.dart';
import 'package:onyx/screens/mails/domain/model/mail_box_model.dart';

part 'generated/mail_box_wrapper.g.dart';

@HiveType(typeId: 21)
class MailBoxWrapper {
  @HiveField(0)
  late List<MailBoxModel> mailBoxes;

  MailBoxWrapper({
    required this.mailBoxes,
  });
}

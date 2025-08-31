import 'package:dart_mappable/dart_mappable.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/mail_box_list.mapper.dart';

@MappableClass()
class MailBoxList with MailBoxListMappable {
  late final List<MailBox> mailBoxes;

  MailBoxList({
    required this.mailBoxes,
  });
}

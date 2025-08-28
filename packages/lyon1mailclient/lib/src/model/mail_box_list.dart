import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/mail_box_list.g.dart';

@CopyWith()
class MailBoxList extends Equatable {
  late final List<MailBox> mailBoxes;

  MailBoxList({
    required this.mailBoxes,
  });

  @override
  List<Object?> get props => [mailBoxes];

  @override
  bool? get stringify => true;
}

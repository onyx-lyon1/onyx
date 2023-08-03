import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';

part 'generated/mail_box_list.g.dart';

@CopyWith()
@HiveType(typeId: 21)
class MailBoxList extends Equatable {
  @HiveField(0)
  late final List<MailBox> mailBoxes;

  MailBoxList({
    required this.mailBoxes,
  });

  @override
  List<Object?> get props => [mailBoxes];

  @override
  bool? get stringify => true;
}

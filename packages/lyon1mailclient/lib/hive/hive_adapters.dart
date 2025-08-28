import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:hive_ce/hive.dart';
import 'package:lyon1mailclient/src/model/action.dart';
import 'package:lyon1mailclient/src/model/action_list.dart';
import 'package:lyon1mailclient/src/model/action_type.dart';
import 'package:lyon1mailclient/src/model/mail.dart';
import 'package:lyon1mailclient/src/model/mail_box.dart';
import 'package:lyon1mailclient/src/model/mail_box_list.dart';

@GenerateAdapters([
  AdapterSpec<Mail>(),
  AdapterSpec<MailBox>(),
  AdapterSpec<SpecialMailBox>(),
  AdapterSpec<MailBoxList>(),
  AdapterSpec<ActionType>(),
  AdapterSpec<Action>(),
  AdapterSpec<ActionList>(),
])
part 'generated/hive_adapters.g.dart';

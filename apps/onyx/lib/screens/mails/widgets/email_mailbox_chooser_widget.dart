import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/mail_box_extension.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailMailboxChooserWidget extends StatefulWidget {
  const MailMailboxChooserWidget({Key? key}) : super(key: key);

  @override
  State<MailMailboxChooserWidget> createState() =>
      _MailMailboxChooserWidgetState();
}

class _MailMailboxChooserWidgetState extends State<MailMailboxChooserWidget> {
  GlobalKey key = GlobalKey();
  late int _key;

  @override
  void initState() {
    _collapse();
    super.initState();
  }

  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: Key(_key.toString()),
            title: Text(
              state.currentMailBox!.name,
              textAlign: TextAlign.center,
            ),
            childrenPadding: EdgeInsets.symmetric(horizontal: 1.5.w),
            backgroundColor: Theme.of(context).colorScheme.background,
            children: state.mailBoxes
                .map((e) => Material(
                      color: (state.currentMailBox!.name == e.name)
                          ? Theme.of(context).primaryColor
                          : null,
                      child: InkWell(
                        onTap: () {
                          context.read<EmailCubit>().load(
                                blockTrackers: context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings
                                    .blockTrackers,
                                mailbox: e,
                              );
                          _collapse();
                        },
                        child: Row(
                          children: [
                            Icon(e.toIcon()),
                            Text(e.name),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}

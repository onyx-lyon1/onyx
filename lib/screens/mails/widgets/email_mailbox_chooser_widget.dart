import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/mail_box_extension.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';

class EmailMailboxChooserWidget extends StatelessWidget {
  const EmailMailboxChooserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return SizedBox(
          //height: 100.h - 2 * Res.bottomNavBarHeight,

          child: SingleChildScrollView(
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(state.currentMailBox!.name),
                  children: state.mailBoxes
                      .map((e) => Material(
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
              ],
            ),
          ),
        );
      },
    );
  }
}

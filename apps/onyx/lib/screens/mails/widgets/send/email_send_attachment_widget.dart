import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MailSendAttachmentWidget extends StatefulWidget {
  const MailSendAttachmentWidget({super.key});

  @override
  State<MailSendAttachmentWidget> createState() =>
      _MailSendAttachmentWidgetState();
}

class _MailSendAttachmentWidgetState extends State<MailSendAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailSendCubit, EmailSendState>(
      builder: (context, state) {
        return Container(
          color: Theme.of(context).cardTheme.color,
          padding: EdgeInsets.all(0.5.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.attachments.length,
            itemBuilder: (context, index) {
              return MailAttachmentWidget(
                fileName: state.attachments[index].path.split("/").last,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (_) => SaveOrOpenDialogWidget(
                      filePath: state.attachments[index].path,
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(AppLocalizations.of(context)
                          .deleteAttachmentConfirmation),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(AppLocalizations.of(context).cancel,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<EmailSendCubit>()
                                .removeAttachment(state.attachments[index]);
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(
                            AppLocalizations.of(context).delete,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

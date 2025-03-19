import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MailSendPage extends StatelessWidget {
  final int? originalMessage;
  final bool? replyAll;
  final bool reply;
  final bool forward;

  const MailSendPage(
      {super.key,
      this.replyAll,
      this.originalMessage,
      this.forward = false,
      this.reply = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmailSendCubit(originalMessage, replyAll, reply, forward),
      child: BlocConsumer<EmailSendCubit, EmailSendState>(
        listener: (context, state) {
          switch (state.status) {
            case EmailSendStatus.sent:
              Navigator.pop(context);
              break;
            case EmailSendStatus.inputNotValid:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  title:
                      Text(AppLocalizations.of(context).mailSendPageErrorTitle),
                ),
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          if (state.status != EmailSendStatus.initial) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                bottomSheet: const EmailSendBottomBarWidget(),
                body: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: ListView(
                    children: [
                      Container(
                        color: Theme.of(context).cardTheme.color,
                        height: 8.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 2.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      title: Text(
                                        AppLocalizations.of(context)
                                            .mailSendPageDiscardTitle,
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context)
                                            .mailSendPageDiscardContent,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context).cancel,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .discard,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Theme.of(context)
                                      .bottomNavigationBarTheme
                                      .unselectedItemColor,
                                  size: 20.sp,
                                ),
                              ),
                              const Spacer(),
                              (state.originalMessage == null)
                                  ? Expanded(
                                      flex: 20,
                                      child: TextField(
                                        controller: state.subjectEditor,
                                        maxLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        cursorColor: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .color!,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .color!,
                                        ),
                                        decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .subject,
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .color!
                                                        .withOpacity(0.5)),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color!,
                                                  width: 1),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                width: 1,
                                              ),
                                            )),
                                      ),
                                    )
                                  : Expanded(
                                      flex: 20,
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context).response,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      if (!state.reply!)
                        Container(
                          color: Theme.of(context).cardTheme.color,
                          height: 7.h,
                          padding: EdgeInsets.all(1.h),
                          child: MailSendAutocompleteWidget(
                              destinationEditor: state.destinationEditor!),
                        ),
                      SizedBox(height: 1.h),
                      if (state.attachments.isNotEmpty)
                        Container(
                          color: Theme.of(context).cardTheme.color,
                          height: 7.h,
                          padding: EdgeInsets.all(1.h),
                          child: const MailSendAttachmentWidget(),
                        ),
                      if (state.attachments.isNotEmpty) SizedBox(height: 1.h),
                      Container(
                        color: Theme.of(context).cardTheme.color,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: QuillEditor.basic(
                                controller: state.controller!,
                                config: QuillEditorConfig(
                                  minHeight: (100 -
                                          (8 +
                                              1 +
                                              ((!state.reply!) ? 7 : 0) +
                                              1 +
                                              ((state.attachments.isNotEmpty)
                                                  ? 8
                                                  : 0)))
                                      .h,
                                ),
                              ),
                            ),
                            (state.originalMessage != null)
                                ? Padding(
                                    padding: EdgeInsets.all(1.h),
                                    child: MailContentWidget(
                                        mail: context
                                            .read<EmailCubit>()
                                            .state
                                            .currentMailBox!
                                            .emails
                                            .firstWhere((element) =>
                                                element.id ==
                                                state.originalMessage)),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

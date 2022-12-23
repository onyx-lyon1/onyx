import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/widgets/core_widget_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailSendPage extends StatelessWidget {
  final int? replyOriginalMessage;
  final bool? replyAll;

  const EmailSendPage({Key? key, this.replyAll, this.replyOriginalMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController subjectEditor = TextEditingController();
    final TextEditingController destinationEditor = TextEditingController();
    final TextEditingController bodyEditor = TextEditingController();
    List<File> attachments = [];

    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (state.status == EmailStatus.error) {
          Future.delayed(const Duration(seconds: 1), () {
            EmailModel email = EmailModel(
              subject: subjectEditor.text,
              sender: "moi",
              excerpt: "",
              isRead: false,
              date: DateTime.now(),
              body: bodyEditor.text,
              id: 0,
              receiver: destinationEditor.text,
              isFlagged: false,
              attachments: [],
            );
            context.read<EmailCubit>().send(
                email: email,
                replyAll: replyAll,
                replyOriginalMessageId: replyOriginalMessage);
          });
          return const StateDisplayingPage(
              message: "Something went wrong with emails");
        } else if (state.status == EmailStatus.sended) {
          context.read<EmailCubit>().load(cache: false);
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
        } else if (state.status == EmailStatus.sending) {
          return const StateDisplayingPage(message: "Sending message");
        }
        return Hero(
          tag: 'writeEmail',
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            floatingActionButton: Material(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: Theme.of(context).cardTheme.color,
                onTap: () {
                  if ((destinationEditor.value.text.isNotEmpty &&
                          subjectEditor.value.text.isNotEmpty &&
                          bodyEditor.value.text.isNotEmpty &&
                          destinationEditor.value.text.contains("@") &&
                          destinationEditor.value.text.contains(".")) ||
                      (replyOriginalMessage != null &&
                          bodyEditor.value.text.isNotEmpty)) {
                    EmailModel email = EmailModel(
                      subject: subjectEditor.text,
                      sender: "moi",
                      excerpt: "",
                      isRead: false,
                      date: DateTime.now(),
                      body: bodyEditor.text,
                      id: 0,
                      receiver: destinationEditor.text,
                      isFlagged: false,
                      attachments: attachments.map((e) => e.path).toList(),
                    );
                    context.read<EmailCubit>().send(
                        email: email,
                        replyAll: replyAll,
                        replyOriginalMessageId: replyOriginalMessage);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: const Text(
                            "Veuillez remplir correctement tous les champs"),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(1.5.h),
                  child: Icon(Icons.send, size: 25.sp),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).cardTheme.color,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            (replyOriginalMessage == null)
                                ? Expanded(
                                    child: Center(
                                      child: TextField(
                                        controller: subjectEditor,
                                        maxLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        cursorColor: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .color!,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .button!
                                              .color!,
                                        ),
                                        decoration: InputDecoration(
                                            hintText: "Objets",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color!
                                                        .withOpacity(0.5)),
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color!,
                                                  width: 1),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                width: 1,
                                              ),
                                            )),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 70.w,
                                    child: const Center(
                                      child: Text(
                                        "reponse",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    (replyOriginalMessage == null)
                        ? Container(
                            color: Theme.of(context).cardTheme.color,
                            width: 100.w,
                            child: Padding(
                              padding: EdgeInsets.all(1.h),
                              child: EmailSendAutocompleteWidget(
                                  destinationEditor: destinationEditor),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: Theme.of(context).cardTheme.color,
                      height: (replyOriginalMessage == null) ? 65.h : 75.h,
                      width: 100.w,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.h),
                            child: TextField(
                              controller: bodyEditor,
                              textAlignVertical: TextAlignVertical.top,
                              cursorColor:
                                  Theme.of(context).textTheme.button!.color!,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.button!.color!,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Message",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.5)),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          (replyOriginalMessage != null)
                              ? Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(1.h),
                                  child: EmailContentWidget(
                                      mail: state.emails.firstWhere((element) =>
                                          element.id == replyOriginalMessage)),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    EmailSendAttachmentWidget(attachments: attachments),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

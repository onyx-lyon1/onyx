import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailDetailsPage extends StatelessWidget {
  final Mail mail;

  const MailDetailsPage({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).cardTheme.color,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            SizedBox(
                              width: 80.w,
                              child: Center(
                                child: Text(
                                  mail.subject,
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
                    Container(
                      color: Theme.of(context).cardTheme.color,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText("De : ${mail.sender}"),
                            SizedBox(
                              height: 1.h,
                            ),
                            SelectableText("À : ${mail.receiver}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: Theme.of(context).cardTheme.color,
                      height: (mail.attachments.isNotEmpty) ? 58.h : 70.h,
                      width: 100.w,
                      padding: EdgeInsets.all(1.h),
                      child: MailContentWidget(mail: mail),
                    ),
                    (mail.attachments.isNotEmpty)
                        ? Container(
                            color: Theme.of(context).cardTheme.color,
                            padding: EdgeInsets.all(0.5.h),
                            height: 12.h,
                            width: 100.w,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mail.attachments.length,
                              itemBuilder: (context, index) {
                                return MailAttachmentWidget(
                                  fileName: mail.attachments[index][0],
                                  onTap: () async {
                                    //save data in a file and open it
                                    if (mail.attachments[index][1] == "") {
                                      mail.attachments[index] =
                                          await AttachmentLogic
                                              .getAttachmentLocalPath(
                                                  email: mail,
                                                  mailClient: context
                                                      .read<EmailCubit>()
                                                      .mailClient!,
                                                  emailNumber:
                                                      state.emailNumber,
                                                  fileName: mail
                                                      .attachments[index][0],
                                                  folder:
                                                      state.currentMailBox!);
                                    }
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (_) => SaveOrOpenDialogWidget(
                                              filePath: mail.attachments[index]
                                                  [1],
                                            ));
                                  },
                                );
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: Res.bottomNavBarHeight,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OpenContainer(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    openBuilder: (context, closewidget) => MailSendPage(
                      replyAll: false,
                      reply: true,
                      originalMessage: mail.id,
                    ),
                    closedBuilder: (context, openwidget) => InkWell(
                      onTap: (!state.connected) ? null : openwidget,
                      child: const Icon(
                        Icons.reply_rounded,
                      ),
                    ),
                  ),
                  OpenContainer(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    openBuilder: (context, closewidget) => MailSendPage(
                      replyAll: true,
                      reply: true,
                      originalMessage: mail.id,
                    ),
                    closedBuilder: (context, openwidget) => InkWell(
                      onTap: (!state.connected) ? null : openwidget,
                      child: const Icon(
                        Icons.reply_all_rounded,
                      ),
                    ),
                  ),
                  OpenContainer(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    openBuilder: (context, closewidget) => MailSendPage(
                      forward: true,
                      originalMessage: mail.id,
                    ),
                    closedBuilder: (context, openwidget) => InkWell(
                      onTap: (!state.connected) ? null : openwidget,
                      child: const Icon(
                        Icons.forward_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
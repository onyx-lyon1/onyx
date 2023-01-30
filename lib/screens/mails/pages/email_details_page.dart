import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailDetailsPage extends StatelessWidget {
  final EmailModel mail;

  const EmailDetailsPage({Key? key, required this.mail}) : super(key: key);

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
                            horizontal: 2.w, vertical: 1.h),
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
                      height: (mail.attachments.isNotEmpty) ? 60.h : 72.h,
                      width: 100.w,
                      padding: EdgeInsets.all(1.h),
                      child: EmailContentWidget(mail: mail),
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
                                return EmailAttachmentWidget(
                                  fileName: mail.attachments[index],
                                  onTap: () async {
                                    //save data in a file and open it
                                    String attachmentPath =
                                        await AttachmentLogic
                                            .getAttachmentLocalPath(
                                                email: mail,
                                                mailClient: context
                                                    .read<EmailCubit>()
                                                    .mailClient,
                                                emailNumber: state.emailNumber,
                                                fileName:
                                                    mail.attachments[index]);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (_) => SaveOrOpenDialogWidget(
                                              filePath: attachmentPath,
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
                  IconButton(
                      onPressed: (!state.connected)
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSendPage(
                                    replyAll: false,
                                    replyOriginalMessage: mail.id,
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(
                        Icons.reply_rounded,
                      )),
                  IconButton(
                      onPressed: (!state.connected)
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSendPage(
                                    replyAll: true,
                                    replyOriginalMessage: mail.id,
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(Icons.reply_all_rounded))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/others/hex.dart';
import 'package:oloid2/page/mails/email_send_page.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailDetailsPage extends StatelessWidget {
  final EmailModel mail;

  const EmailDetailsPage({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
    return Scaffold(
      floatingActionButton: SpeedDial(
        buttonSize: Size(15.w, 15.w),
        backgroundColor: Theme.of(context).primaryColor,
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailSendPage(
                            replyAll: false,
                            replyOriginalMessage: mail.id,
                          )));
            },
            child: Icon(
              Icons.reply,
              size: 20.sp,
            ),
          ),
          SpeedDialChild(
            onTap: () {
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
            child: Icon(
              Icons.reply_all,
              size: 20.sp,
            ),
          ),
        ],
        icon: Icons.reply,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: 100.w,
        height: 100.h,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).cardTheme.color,
                height: 6.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<EmailBloc>().add(EmailLoad());
                          Navigator.pop(context);
                        },
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
                      SizedBox(
                        width: 85.w,
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
                height: 11.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("de: ${mail.sender}"),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "à: ${mail.receiver}",
                        overflow: TextOverflow.fade,
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
                padding: EdgeInsets.all(1.h),
                height: 78.h,
                width: 100.w,
                child: (mail.body.toLowerCase().contains("html") &&
                        (Platform.isAndroid || Platform.isIOS))
                    ? WebView(
                        initialUrl: '',
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureRecognizers: Platform.isAndroid
                            ? {Factory(() => EagerGestureRecognizer())}
                            : null,
                        onWebViewCreated: (controller) async {
                          webViewController = controller;
                          webViewController.loadUrl(((context
                                      .read<SettingsBloc>()
                                      .settings
                                      .darkerMail)
                                  ? Uri.dataFromString(
                                      //add background screen
                                      '<!DOCTYPE html>'
                                      '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                                      '<style>body { background-color: ${Theme.of(context).backgroundColor.toHex()}; } </style>'
                                      '</head>'
                                      '<body text="${Theme.of(context).textTheme.bodyText2?.color?.toHex()}" >'
                                      '${mail.body}'
                                      '</body>',
                                      mimeType: 'text/html',
                                      encoding: Encoding.getByName('utf-8'))
                                  : Uri.dataFromString(mail.body))
                              .toString());
                        },
                      )
                    : SelectableText(mail.body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

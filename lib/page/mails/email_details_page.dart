import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/model/mail_model.dart';
import 'package:oloid2/states/email/email_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailDetailsPage extends StatelessWidget {
  final EmailModel mail;

  const EmailDetailsPage({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
    return Material(
      child: Container(
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
                height: 10.h,
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
                        "a: ${mail.receiver}",
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
                height: 78.h,
                width: 100.w,
                child: (mail.body.toLowerCase().contains("html") &&
                        (Platform.isAndroid || Platform.isIOS))
                    ? WebView(
                        initialUrl: '',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) async {
                          webViewController = controller;
                          webViewController.loadUrl(Uri.dataFromString(
                                  mail.body,
                                  mimeType: 'text/html',
                                  encoding: Encoding.getByName('utf-8'))
                              .toString());
                        },
                      )
                    : Text(mail.body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/extensions/extensions_export.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailDetailsPage extends StatelessWidget {
  final EmailModel mail;

  const EmailDetailsPage({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return Scaffold(
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
                    height: 13.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText("de: ${mail.sender}"),
                          SizedBox(
                            height: 1.h,
                          ),
                          SelectableText("à: ${mail.receiver}"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).cardTheme.color,
                      padding: EdgeInsets.all(1.h),
                      // height: 57.h,
                      // width: 100.w,
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
                                            .read<SettingsCubit>()
                                            .state
                                            .settings
                                            .darkerMail)
                                        ? Uri.dataFromString(
                                            //add background screen
                                            '<!DOCTYPE html>'
                                            '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                                            '<style>body { background-color: ${Theme.of(context).cardTheme.color!.toHex()}; } </style>'
                                            '</head>'
                                            '<body text="${Theme.of(context).textTheme.bodyText2?.color?.toHex()}" >'
                                            '${mail.body}'
                                            '</body>',
                                            mimeType: 'text/html',
                                            encoding:
                                                Encoding.getByName('utf-8'))
                                        : Uri.dataFromString(
                                            //add background screen
                                            '<!DOCTYPE html>'
                                            '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                                            '</head>'
                                            '<body>'
                                            '${mail.body}'
                                            '</body>',
                                            mimeType: 'text/html',
                                            encoding:
                                                Encoding.getByName('utf-8')))
                                    .toString());
                              },
                              navigationDelegate:
                                  (NavigationRequest request) async {
                                if (await canLaunchUrl(
                                    Uri.parse(request.url))) {
                                  await launchUrl(Uri.parse(request.url),
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not launch ${request.url}';
                                }
                                return NavigationDecision.prevent;
                              },
                            )
                          : SelectableText(mail.body),
                    ),
                  ),
                  (mail.attachments.isNotEmpty)
                      ? Container(
                          color: Theme.of(context).cardTheme.color,
                          padding: EdgeInsets.all(1.h),
                          height: 12.h,
                          width: 100.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mail.attachments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(1.h),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      //save data in a file and open it
                                      final directory =
                                          await getTemporaryDirectory();
                                      final file = File(
                                          '${directory.path}/${mail.attachments[index].name}');
                                      await file.writeAsBytes(
                                          mail.attachments[index].data);
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              SaveOrOpenDialogWidget(
                                                filePath: file.path,
                                              ));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_file,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          mail.attachments[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 10.h,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: (state.status == EmailStatus.initial ||
                            state.status == EmailStatus.connecting ||
                            state.status == EmailStatus.cacheLoaded)
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
                      Icons.reply,
                    )),
                IconButton(
                    onPressed: (state.status == EmailStatus.initial ||
                            state.status == EmailStatus.connecting ||
                            state.status == EmailStatus.cacheLoaded)
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
                    icon: const Icon(Icons.reply_all))
              ],
            ),
          ),
        );
      },
    );
  }
}

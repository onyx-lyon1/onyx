import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/core/extensions/extensions_export.dart';
import 'package:oloid2/screens/mails/domain/model/mail_model.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailContentWidget extends StatelessWidget {
  final EmailModel mail;

  const EmailContentWidget({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController;
    return (mail.body.toLowerCase().contains("html") &&
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
                          encoding: Encoding.getByName('utf-8'))
                      : Uri.dataFromString(
                          //add background screen
                          '<!DOCTYPE html>'
                          '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                          '</head>'
                          '<body>'
                          '${mail.body}'
                          '</body>',
                          mimeType: 'text/html',
                          encoding: Encoding.getByName('utf-8')))
                  .toString());
            },
            navigationDelegate: (NavigationRequest request) async {
              if (await canLaunchUrl(Uri.parse(request.url))) {
                await launchUrl(Uri.parse(request.url),
                    mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch ${request.url}';
              }
              return NavigationDecision.prevent;
            },
          )
        : SelectableText(
            mail.body,
            textAlign: TextAlign.left,
          );
  }
}

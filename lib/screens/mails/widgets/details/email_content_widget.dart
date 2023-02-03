import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/mails/domain/model/email_model.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailContentWidget extends StatelessWidget {
  final EmailModel mail;

  const EmailContentWidget({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController = WebViewController();
    if ((mail.body.contains("<html") &&
        (Platform.isAndroid || Platform.isIOS))) {
      webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController
          .setBackgroundColor(Theme.of(context).colorScheme.background);
      webViewController.setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            print("nav request: ${request.url}");
            if (await canLaunchUrl(Uri.parse(request.url))) {
              await launchUrl(Uri.parse(request.url),
                  mode: LaunchMode.externalApplication);
            } else {
              throw 'Could not launch ${request.url}';
            }
            return NavigationDecision.prevent;
          },
        ),
      );
      webViewController.loadHtmlString(
        (context.read<SettingsCubit>().state.settings.darkerMail)
            ?
            //add background screen
            '<!DOCTYPE html>'
                '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                '<style>body { background-color: ${Theme.of(context).cardTheme.color!.toHex()}; } </style>'
                '</head>'
                '<body text="${Theme.of(context).textTheme.bodyMedium?.color?.toHex()}" >'
                '${mail.body}'
                '</body>'
            :
            //add background screen
            '<!DOCTYPE html>'
                '<head><meta name="viewport" content="width=device-width, initial-scale=1.0">'
                '</head>'
                '<body>'
                '${mail.body}'
                '</body>',
      );
    }
    return (mail.body.contains("<html") &&
            (Platform.isAndroid || Platform.isIOS))
        ? WebViewWidget(
            controller: webViewController,
            gestureRecognizers: {
              Factory(() => EagerGestureRecognizer())
            }, //maybe causing bug on ios
          )
        : SelectableText(
            mail.body,
            textAlign: TextAlign.left,
          );
  }
}

import 'dart:io';

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
    late WebViewController webViewController;
    if ((mail.body.toLowerCase().contains("html") &&
        (Platform.isAndroid || Platform.isIOS))) {
      webViewController = WebViewController();
      webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController.setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
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
    return (mail.body.toLowerCase().contains("html") &&
            (Platform.isAndroid || Platform.isIOS))
        ? WebViewWidget(
            controller: webViewController,
            // gestureRecognizers: Platform.isAndroid
            //     ? {Factory(() => EagerGestureRecognizer())}
            //     : null,
          )
        : SelectableText(
            mail.body,
            textAlign: TextAlign.left,
          );
  }
}

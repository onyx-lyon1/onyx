import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/mails/domain/model/email_model.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailContentWidget extends StatefulWidget {
  final EmailModel mail;

  const EmailContentWidget({Key? key, required this.mail}) : super(key: key);

  @override
  State<EmailContentWidget> createState() => _EmailContentWidgetState();
}

class _EmailContentWidgetState extends State<EmailContentWidget> {
  final WebViewController webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    if (((widget.mail.body.contains("<html") ||
            widget.mail.body.contains("text/html")) &&
        (Platform.isAndroid || Platform.isIOS))) {
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

      webViewController
          .setBackgroundColor(Theme.of(context).colorScheme.background);
      String html = widget.mail.body;
      if (context.read<SettingsCubit>().state.settings.darkerMail) {
        if (Theme.of(context).brightness == Brightness.dark) {
          html = widget.mail.blackBody;
        }
      }
      webViewController.loadHtmlString(
        html,
      );
    }
    return ((widget.mail.body.contains("<html") ||
                widget.mail.body.contains("text/html")) &&
            (Platform.isAndroid || Platform.isIOS))
        ? WebViewWidget(
            controller: webViewController,
            gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
            //maybe causing bug on ios
          )
        : SelectableText(
            widget.mail.body,
            textAlign: TextAlign.left,
          );
  }
}

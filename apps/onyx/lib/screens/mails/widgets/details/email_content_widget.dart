import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MailContentWidget extends StatefulWidget {
  final Mail mail;

  const MailContentWidget({super.key, required this.mail});

  @override
  State<MailContentWidget> createState() => _MailContentWidgetState();
}

class _MailContentWidgetState extends State<MailContentWidget> {
  late final WebViewController? webViewController;

  @override
  void initState() {
    if ((!kIsWeb && (Platform.isAndroid || Platform.isIOS))) {
      webViewController = WebViewController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String html = widget.mail.body;
    if (context.read<SettingsCubit>().state.settings.forcedMailTheme) {
      bool isDark = Theme.of(context).brightness == Brightness.dark;
      html = widget.mail.getThemedBody(
        isDarkMode: isDark,
        bgColor: Theme.of(context).cardTheme.color!.toHex(),
        textColor: Theme.of(context).textTheme.bodyMedium!.color!.toHex(),
      );
    }
    
    if (((widget.mail.body.contains("<html") ||
            widget.mail.body.contains("text/html")) &&
        (!kIsWeb && (Platform.isAndroid || Platform.isIOS)))) {
      webViewController!.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController!.setNavigationDelegate(
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

      webViewController!
          .setBackgroundColor(Theme.of(context).colorScheme.background);
      webViewController!.loadHtmlString(
        html,
      );
    }
    return ((widget.mail.body.contains("<html") ||
                widget.mail.body.contains("text/html")) &&
            (!kIsWeb && (Platform.isAndroid || Platform.isIOS)))
        ? WebViewWidget(
            controller: webViewController!,
            gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
            //maybe causing bug on ios
          )
        : SelectableText(
            html,
            textAlign: TextAlign.left,
          );
  }
}

import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onyx/l10n/app_localizations.dart';

class URLCompactWidget extends StatelessWidget {
  final URL url;
  final Function()? onTap;
  final String teachingUnitTitle;

  const URLCompactWidget(
      {super.key,
      required this.url,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      text1: url.title,
      text3: teachingUnitTitle,
      child2: IconButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(url.value))) {
              await launchUrl(Uri.parse(url.value),
                  mode: LaunchMode.externalApplication);
            } else {
              showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context).error),
                        content:
                            Text(AppLocalizations.of(context).unableToOpenLink),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(AppLocalizations.of(context).ok),
                          )
                        ],
                      ));
            }
          },
          icon: const Icon(Icons.open_in_new_rounded)),
      onTap: onTap,
    );
  }
}

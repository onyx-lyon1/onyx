import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onyx/l10n/app_localizations.dart';

class URLWidget extends StatelessWidget {
  final URL url;

  const URLWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
      left: IconButton(
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
                              child: Text(AppLocalizations.of(context).ok))
                        ],
                      ));
            }
          },
          icon: const Icon(Icons.open_in_new_rounded, color: Colors.white)),
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            url.title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 15.sp,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              url.author,
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

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
              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Erreur'),
                        content: const Text('Impossible d\'ouvrir le lien'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'))
                        ],
                      ));
            }
          },
          icon: const Icon(Icons.open_in_new_rounded)),
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            url.title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 11.sp,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              url.author,
              maxLines: 3,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                overflow: TextOverflow.ellipsis,
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

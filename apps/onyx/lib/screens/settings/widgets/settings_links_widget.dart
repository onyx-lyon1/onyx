import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsLinkWidget extends StatelessWidget {
  const SettingsLinkWidget({Key? key}) : super(key: key);

  //https://oloid.clementherve.fr/

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              launchUrl(Uri.parse('https://discord.gg/ReUKtKU523'),
                  mode: LaunchMode.externalApplication);
            },
            child: Image.asset(
              'assets/discord_Logo.png',
              width: 40.w,
              height: 40.w,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
              onTap: () {
                launchUrl(Uri.parse('https://onyx-lyon1.github.io/'),
                    mode: LaunchMode.externalApplication);
              },
              child: Icon(
                Icons.info_outline,
                size: 40.w,
              )),
        ]);
  }
}

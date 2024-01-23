import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsLinkWidget extends StatelessWidget {
  const SettingsLinkWidget({super.key});

  //https://oloid.clementherve.fr/

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              launchUrl(Uri.parse(Res.discordUrl),
                  mode: LaunchMode.externalApplication);
            },
            child: Image.asset(
              Res.discordLogoPath,
              width: (!Res.isWide) ? 40.w : 20.h,
              height: (!Res.isWide) ? 40.w : 20.h,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
              onTap: () {
                launchUrl(Uri.parse(Res.websiteUrl),
                    mode: LaunchMode.externalApplication);
              },
              child: Icon(
                Icons.info_outline,
                size: (!Res.isWide) ? 40.w : 20.h,
              )),
        ]);
  }
}

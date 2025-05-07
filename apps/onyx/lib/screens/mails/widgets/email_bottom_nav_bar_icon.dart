import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:onyx/l10n/app_localizations.dart';

class MailBottomNavBarIcon extends StatelessWidget {
  const MailBottomNavBarIcon({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          Icon(
            Icons.email_rounded,
            color: selected
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
                : Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
          ),
          Text(
            AppLocalizations.of(context).mails,
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

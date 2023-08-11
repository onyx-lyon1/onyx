import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/extensions/presence_color_to_flutter_color.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PresenceWidget extends StatelessWidget {
  final Presence presence;

  const PresenceWidget({super.key, required this.presence});

  @override
  Widget build(BuildContext context) {
    return TomussElementWidget(
        color: presence.color.toColor(),
        left: Center(
          child: Text(
            presence.value,
            maxLines: 4,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (presence.color == PresenceColor.green)
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 11.sp,
            ),
          ),
        ),
        right: Stack(
          children: [
            Center(
              child: Text(
                presence.title,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                presence.author,
                maxLines: 3,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ));
  }
}

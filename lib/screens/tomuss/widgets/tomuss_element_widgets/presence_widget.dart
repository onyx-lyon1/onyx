import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/core/extensions/presence_color_to_flutter_color.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

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
      right: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            presence.title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 11.sp,
            ),
          ),
          Text(
            presence.author,
            maxLines: 3,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              overflow: TextOverflow.ellipsis,
              fontSize: 7.sp,
            ),
          ),
        ],
      ),
    );
  }
}

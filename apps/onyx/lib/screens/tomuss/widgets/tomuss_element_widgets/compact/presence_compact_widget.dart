import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class PresenceCompactWidget extends StatelessWidget {
  final Presence presence;
  final Function()? onTap;
  final String teachingUnitTitle;

  const PresenceCompactWidget(
      {super.key,
      required this.presence,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      text1: presence.value,
      text2: presence.title,
      text3: teachingUnitTitle,
      color: presence.color.toColor(),
      onTap: onTap,
    );
  }
}

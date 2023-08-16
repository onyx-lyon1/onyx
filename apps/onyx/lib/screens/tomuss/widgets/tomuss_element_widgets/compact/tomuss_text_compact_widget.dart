import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class TomussTextCompactWidget extends StatelessWidget {
  final TomussText text;
  final Function()? onTap;
  final String teachingUnitTitle;

  const TomussTextCompactWidget(
      {super.key,
      required this.text,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      text1: text.value,
      text2: text.title,
      text3: teachingUnitTitle,
      onTap: onTap,
    );
  }
}

import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

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
      text1: "",
      text2: url.title,
      text3: teachingUnitTitle,
      onTap: onTap,
    );
  }
}

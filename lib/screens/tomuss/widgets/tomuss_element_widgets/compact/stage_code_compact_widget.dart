import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class StageCodeCompactWidget extends StatelessWidget {
  final StageCode stageCode;
  final Function()? onTap;
  final String teachingUnitTitle;

  const StageCodeCompactWidget(
      {super.key,
      required this.stageCode,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      text1: stageCode.title,
      text2: stageCode.value,
      text3: teachingUnitTitle,
      onTap: onTap,
    );
  }
}

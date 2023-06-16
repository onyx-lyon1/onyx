import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class UploadCompactWidget extends StatelessWidget {
  final Upload upload;
  final Function()? onTap;
  final String teachingUnitTitle;

  const UploadCompactWidget(
      {super.key,
      required this.upload,
      required this.onTap,
      required this.teachingUnitTitle});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      // text1: upload.value,
      text1: "",
      text2: upload.title,
      text3: teachingUnitTitle, onTap: onTap,
    );
  }
}

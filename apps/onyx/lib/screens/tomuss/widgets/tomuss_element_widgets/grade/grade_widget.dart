import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class GradeWidget extends StatelessWidget {
  final List<Grade> grades;
  final String text1;
  final String text2;
  final bool isSeen;
  final VoidCallback? onTap;
  final int depth;

  const GradeWidget({
    Key? key,
    required this.grades,
    required this.text1,
    required this.text2,
    required this.depth,
    this.isSeen = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    double numerator = 0;
    double denominator = 0;
    if (depth != 0) {
      numerator = grades.first.numerator;
      denominator = grades.first.denominator;
    } else {
      if (grades.length == 1) {
        denominator = grades.first.denominator;
      } else {
        denominator = 20;
      }
      double coefSum = 0.0;
      for (var i in grades) {
        if (!i.numerator.isNaN && !i.denominator.isNaN) {
          numerator += (i.numerator / i.denominator) * (i.coef);
          coefSum += (i.coef);
        }
      }
      numerator = (numerator / ((coefSum != 0) ? coefSum : 1)) * denominator;
    }
    String gradeNumerator =
        ((grades.isNotEmpty) ? numerator.toStringAsPrecision(3) : '-');
    return GestureDetector(
        onTap: (onTap != null) ? () => onTap!() : null,
        child: TomussElementWidget(
          color: TomussLogic.getMainGradeColor(
              forceGreen:
                  context.read<SettingsCubit>().state.settings.forceGreen,
              isSeen: isSeen,
              grades: grades),
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  gradeNumerator,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: OnyxTheme.darkTheme().colorScheme.background,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Container(
                width: 15.w,
                height: 0.2.h,
                color: OnyxTheme.darkTheme().colorScheme.background,
              ),
              Text(
                ((grades.isNotEmpty) ? denominator : '-').toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: OnyxTheme.darkTheme().colorScheme.background,
                    fontSize: 15),
              ),
            ],
          ),
          right: Row(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                      width: 70.w,
                      child: Text(
                        text1,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                      width: 70.w,
                      child: Text(
                        text2,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 7.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (depth == 1) GradeCoefWidget(grade: grades.first),
              IconButton(
                  onPressed: () async {
                    Directory tmpDir = await getTemporaryDirectory();
                    await screenshotController.captureAndSave(
                      tmpDir.path,
                      pixelRatio: 3.0,
                      fileName: 'screenshot.png',
                    );
                    Share.shareXFiles([XFile("${tmpDir.path}/screenshot.png")],
                        text: "Voici ma note en ${grades.first.title} !");
                  },
                  icon: Icon(
                    Icons.share_rounded,
                    size: 20.sp,
                  )),
            ],
          ),
          onTap: onTap,
        ));
  }
}

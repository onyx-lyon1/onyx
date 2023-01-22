import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class GradeWidget extends StatefulWidget {
  final List<GradeModel> grades;
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
  State<GradeWidget> createState() => _GradeWidgetState();
}

class _GradeWidgetState extends State<GradeWidget> {
  ScreenshotController screenshotController = ScreenshotController();

  Color _mainGradeColor(BuildContext context) {
    if (context.read<SettingsCubit>().state.settings.forceGreen) {
      return widget.isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      if (widget.grades.isEmpty) {
        return widget.isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
      } else {
        if (widget.grades.length == 1) {
          return _gradeColor(context, widget.grades.first);
        }
        double a = 0;
        double r = 0;
        double g = 0;
        double b = 0;
        double coefSum = 0;
        for (var i in widget.grades) {
          Color tmpColor = _gradeColor(context, i);
          a += tmpColor.alpha * (i.coef ?? 1.0);
          r += tmpColor.red * (i.coef ?? 1.0);
          g += tmpColor.green * (i.coef ?? 1.0);
          b += tmpColor.blue * (i.coef ?? 1.0);
          coefSum += i.coef ?? 1.0;
        }
        if (coefSum == 0) {
          coefSum = 1;
        }
        a = (a / coefSum);
        r = (r / coefSum);
        g = (g / coefSum);
        b = (b / coefSum);
        return Color.fromARGB(a.round(), r.round(), g.round(), b.round());
      }
    }
  }

  /* original tomuss code
  function rank_to_color(rank, nr) {
    var x = Math.floor(511 * rank / nr);
    var b, c = '';
    if (rank > nr / 2) {
        b = '255,' + (511 - x) + ',' + (511 - x);
        if (rank > 3 * nr / 4)
            c = ';color:#FFF';
    }
    else
        b = x + ',255,' + x;

    return 'background: rgb(' + b + ')' + c
  }
   */
  Color _gradeColor(BuildContext context, GradeModel grade) {
    if (context.read<SettingsCubit>().state.settings.forceGreen ||
        !grade.isValidGrade) {
      return widget.isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      var x = (511 * grade.rank / grade.groupSize).floor();
      Color b = Colors.red;
      if (grade.rank > grade.groupSize / 2) {
        b = Color.fromARGB(255, 255, 511 - x, 511 - x);
      } else {
        b = Color.fromARGB(255, x, 255, x);
      }
      return b;
    }
  }

  @override
  Widget build(BuildContext context) {
    double numerator = 0;
    double denominator = 0;
    if (widget.depth != 0) {
      numerator = widget.grades.first.gradeNumerator;
      denominator = widget.grades.first.gradeDenominator;
    } else {
      if (widget.grades.length == 1) {
        denominator = widget.grades.first.gradeDenominator;
      } else {
        denominator = 20;
      }
      double coefSum = 0.0;
      for (var i in widget.grades) {
        if (!i.gradeNumerator.isNaN && !i.gradeDenominator.isNaN) {
          numerator +=
              (i.gradeNumerator / i.gradeDenominator) * (i.coef ?? 1.0);
          coefSum += (i.coef ?? 1.0);
        }
      }
      numerator = (numerator / ((coefSum != 0) ? coefSum : 1)) * denominator;
    }
    String gradeNumerator =
        ((widget.grades.isNotEmpty) ? numerator.toStringAsPrecision(3) : '-');

    return GestureDetector(
      onTap: (widget.onTap != null) ? () => widget.onTap!() : null,
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          height: 11.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 11.h,
                width: 20.w,
                decoration: BoxDecoration(
                  color: _mainGradeColor(context),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                ),
                child: Column(
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
                      ((widget.grades.isNotEmpty) ? denominator : '-')
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: OnyxTheme.darkTheme().colorScheme.background,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 0.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                        child: AutoSizeText(
                          widget.text1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      AutoSizeText(
                        widget.text2,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        maxFontSize: 12,
                        minFontSize: 5,
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.depth == 1) GradeCoefWidget(grades: widget.grades),
              IconButton(
                  onPressed: () async {
                    Directory tmpDir = await getTemporaryDirectory();
                    await screenshotController.captureAndSave(
                      tmpDir.path,
                      pixelRatio: 3.0,
                      fileName: 'screenshot.png',
                    );
                    Share.shareXFiles([XFile("${tmpDir.path}/screenshot.png")],
                        text: "Voici ma note en ${widget.grades.first.name} !");
                  },
                  icon: Icon(
                    Icons.share_rounded,
                    size: 20.sp,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

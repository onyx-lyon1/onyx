// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:oloid2/core/theme/grade_color.dart';
import 'package:oloid2/core/theme/theme.dart';
import 'package:oloid2/screens/tomuss/domain/model/grade_model.dart';
import 'package:oloid2/screens/tomuss/domain/model/school_subject_model.dart';
import 'package:sizer/sizer.dart';

class GradeWidget extends StatelessWidget {
  final dynamic model;
  late String gradeNumerator;
  late String gradeDenominator;
  late String text1;
  late String text2;
  final bool forceGreen;
  final bool isSeen;
  late int? rank;
  late int groupeSize;
  final void Function(dynamic o)? onTap;

  GradeWidget({Key? key,
    required this.model,
    this.groupeSize = 120,
    this.rank,
    required this.forceGreen,
    required this.isSeen,
    this.onTap,
  }) : super(key: key){
    if (model is GradeModel) {

      gradeNumerator = model.gradeNumerator.toString();
      gradeDenominator = model.gradeDenominator.toString();
      groupeSize = model.groupSize;
      rank = model.rank;
      text1 = model.name;
      text2 = "moyenne: ${model.average.toStringAsFixed(2)} · mediane: ${model.mediane.toStringAsFixed(2)}\nclassement:${model.rank + 1}/${model.groupSize}\nprofesseur: ${model.author}";
    } else if (model is SchoolSubjectModel) {
      gradeDenominator = ((model.grades.isNotEmpty) ? 20 : '-').toString();
      text2 = "${model.mastersShort()} • grp ?";
      text1 = model.name;
      int rank = 0;
      for (var i in (model as SchoolSubjectModel).grades) {
        if (!i.rank.isNaN) {
          rank += i.rank;
        }
      }
      rank = (rank / ((model.grades.isNotEmpty) ? model.grades.length : 1)).round();

      double numerator = 0;
      int numeratorCount = 0;
      for (var i in model.grades) {
        if (!i.gradeNumerator.isNaN && !i.gradeDenominator.isNaN) {
          numerator += i.gradeNumerator / i.gradeDenominator;
          numeratorCount++;
        }
      }
      numerator = (numerator / ((numeratorCount != 0) ? numeratorCount : 1)) * 20;
      gradeNumerator = ((model.grades.isNotEmpty) ? numerator.toStringAsPrecision(3) : '-');

    }
  }

  Color _mainGradeColor(BuildContext context) {
    if (forceGreen || rank == null) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      if (model is GradeModel) {
        return _gradeColor(model);
      } else if (model is SchoolSubjectModel) {
        if (model.grades.isNotEmpty) {
          int red = 0;
          int green = 0;
          int blue = 0;
          for (var i in model.grades) {
            Color color = _gradeColor(i);
            red += color.red;
            green += color.green;
            blue += color.blue;
          }

          red = (red / ((model.grades.length == 0) ? 1 : model.grades.length)).round();
          green =
              (green / ((model.grades.length == 0) ? 1 : model.grades.length)).round();
          blue =
              (blue / ((model.grades.length == 0) ? 1 : model.grades.length)).round();
          return Color.fromARGB(255, red, green, blue);
        } else {
          return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
        }
      }
    }
    return Theme.of(context).backgroundColor;
  }

  Color _gradeColor(GradeModel grade) {
    if (forceGreen || !grade.isValidGrade) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      var x = (511 * grade.rank / grade.groupSize).floor();
      Color b = Colors.red;
      if (grade.rank > grade.groupSize / 2) {
        b = Color.fromARGB(255, 255, 511 - x, 511 - x);
        if (grade.rank > 3 * grade.groupSize / 4) {
          b = GradeColor.seenGreen;
          //TODO add more explicit felicitation
        }
      } else {
        b = Color.fromARGB(255, x, 255, x);
      }
      return b;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap != null) ? () => onTap!(model) : null, // TODO: give it the required infos
      child: Container(
        height: 11.h,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 1)],
          color: Theme.of(context).cardTheme.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(children: [
          Container(
            height: 11.h,
            width: 25.w,
            decoration: BoxDecoration(color: _mainGradeColor(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    gradeNumerator,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: OloidTheme.darkTheme().backgroundColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  width: 15.w,
                  height: 0.2.h,
                  color: OloidTheme.darkTheme().backgroundColor,
                ),
                Text(
                  gradeDenominator,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: OloidTheme.darkTheme().backgroundColor,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        overflow: TextOverflow.clip,
                        fontSize: 10.sp),
                  ),
                  Text(
                    text2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

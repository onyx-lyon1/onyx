import 'package:flutter/material.dart';
import 'package:oloid2/model/grade_model.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/theme/grade_color.dart';
import 'package:sizer/sizer.dart';

class Card extends StatelessWidget {
  final dynamic o;
  final String gradeNumerator;
  final String gradeDenominator;
  final String text1;
  final String text2;
  final bool forceGreen;
  final bool isSeen;
  final int? rank;
  final int groupeSize;
  final Function(dynamic o) onTap;

  const Card({
    Key? key,
    required this.o,
    this.rank,
    required this.groupeSize,
    required this.text1,
    required this.gradeNumerator,
    required this.gradeDenominator,
    required this.text2,
    required this.forceGreen,
    required this.isSeen,
    required this.onTap,
  }) : super(key: key);

  Color _mainGradeColor(BuildContext context) {
    if (forceGreen || rank == null) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      if (o is GradeModel) {
        return _gradeColor(o);
      } else if (o is TeachingUnitModel) {
        if (o.grades.isNotEmpty) {
          int red = 0;
          int green = 0;
          int blue = 0;
          for (var i in o.grades) {
            Color color = _gradeColor(i);
            red += color.red;
            green += color.green;
            blue += color.blue;
          }

          red = (red / ((o.grades.length == 0) ? 1 : o.grades.length)).round();
          green =
              (green / ((o.grades.length == 0) ? 1 : o.grades.length)).round();
          blue =
              (blue / ((o.grades.length == 0) ? 1 : o.grades.length)).round();
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
      onTap: () => onTap(o), // TODO: give it the required infos
      child: Container(
        height: 11.h,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 1)],
          color: Theme.of(context).cardTheme.color,
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
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
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  width: 15.w,
                  height: 0.2.h,
                  color: Colors.white54,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    gradeDenominator,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 10),
            width: 60.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      overflow: TextOverflow.clip),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.8),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

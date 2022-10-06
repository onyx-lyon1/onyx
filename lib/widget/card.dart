import 'package:flutter/material.dart';
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

  Color _mainGradeColor() {
    if (forceGreen || rank == null) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      var x = (511 * rank! / groupeSize).floor();
      Color b = Colors.red;
      Color c = Colors.red;
      if (rank! > groupeSize / 2) {
        b = Color.fromARGB(255, 255, 511 - x, 511 - x);
        if (rank! > 3 * groupeSize / 4) {
          c = Colors.white;
        } else {
          b = Color.fromARGB(255, x, 255, x);
        }
      }
      return b;
      // return 'background: rgb(' + b + ')' + c;

    }
    final double gradeValue =
        double.tryParse(gradeNumerator) ?? double.infinity;
    final double gradeDenominatorValue =
        double.tryParse(gradeDenominator) ?? double.infinity;
    final bool isGreen =
        (gradeValue >= (gradeDenominatorValue / 2)) || forceGreen;
    if (isGreen) {
      return isSeen ? GradeColor.seenGreen : GradeColor.unseenGreen;
    } else {
      return isSeen ? GradeColor.seenRed : GradeColor.unseenRed;
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
            decoration: BoxDecoration(color: _mainGradeColor()),
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

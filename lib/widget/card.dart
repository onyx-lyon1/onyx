import 'package:flutter/material.dart';
import 'package:oloid2/theme/grade_color.dart';

class Card extends StatelessWidget {
  final String gradeNumerator;
  final String gradeDenominator;
  final String text1;
  final String text2;
  final bool forceGreen;
  final bool isSeen;

  const Card({
    Key? key,
    required this.text1,
    required this.gradeNumerator,
    required this.gradeDenominator,
    required this.text2,
    required this.forceGreen,
    required this.isSeen,
  }) : super(key: key);

  Color _mainGradeColor() {
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
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 2)],
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Row(children: [
        Container(
          height: 70,
          width: 90,
          decoration: BoxDecoration(color: _mainGradeColor()),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  gradeNumerator,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 1,
                margin: const EdgeInsets.only(top: 44, left: 22),
                color: Colors.white54,
              ),
              Container(
                padding: const EdgeInsets.only(top: 48),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
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
    );
  }
}

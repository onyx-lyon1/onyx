import 'package:dartus/tomuss.dart' as dartus;
import 'package:flutter/widgets.dart';
import 'package:oloid2/widget/card.dart' as gradeCard;

class Grade extends StatelessWidget {
  final dartus.Grade grade; // TODO: repository + model

  const Grade({
    Key? key,
    required this.grade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: gradeCard.Card(
      text1: grade.name,
      text2:
          "${grade.average.toStringAsFixed(2)} • ${grade.mediane.toStringAsFixed(2)} • ${grade.author}",
      gradeNumerator: grade.gradeNumerator.toString(),
      gradeDenominator: grade.gradeDenominator.toString(),
      forceGreen: false, // TODO
      isSeen: false, // TODO
    ));
  }
}

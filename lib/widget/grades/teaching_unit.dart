import 'package:flutter/material.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/widget/card.dart' as widgets;

class TeachingUnit extends StatelessWidget {
  final TeachingUnitModel tu;
  final bool forceGreen;
  final Function(TeachingUnitModel tu) onClick;

  const TeachingUnit({
    Key? key,
    required this.tu,
    required this.forceGreen,
    required this.onClick,
  }) : super(key: key);

  // "$teacher • grp $group"
  @override
  Widget build(BuildContext context) {
    int rank = 0;
    for (var i in tu.grades) {
      if (!i.rank.isNaN) {
        rank += i.rank;
      }
    }
    rank = (rank / ((tu.grades.isNotEmpty) ? tu.grades.length : 1)).round();

    double numerator = 0;
    int numeratorCount = 0;
    for (var i in tu.grades) {
      if (!i.gradeNumerator.isNaN && !i.gradeDenominator.isNaN) {
        numerator += i.gradeNumerator / i.gradeDenominator;
        numeratorCount++;
      }
    }
    numerator = (numerator / ((numeratorCount != 0) ? numeratorCount : 1)) * 20;

    return GestureDetector(
        onTap: () => onClick(tu),
        child: widgets.Card(
          o: tu,
          groupeSize: 120,
          text1: tu.name,
          text2: "${tu.mastersShort()} • grp ?",
          rank: rank,
          gradeNumerator:
              ((tu.grades.isNotEmpty) ? numerator.toStringAsPrecision(3) : '-'),
          gradeDenominator: ((tu.grades.isNotEmpty) ? 20 : '-').toString(),
          forceGreen: forceGreen,
          isSeen: tu.isSeen,
          onTap: (tu) => onClick(tu),
        ));
  }
}

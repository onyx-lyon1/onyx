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
      rank += i.rank;
    }
    rank = (rank / ((tu.grades.isNotEmpty) ? tu.grades.length : 1)).round();

    return GestureDetector(
        onTap: () => onClick(tu),
        child: widgets.Card(
          o: tu,
          groupeSize: 120,
          text1: tu.name,
          text2: "${tu.mastersShort()} • grp ?",
          rank: rank,
          gradeNumerator: (tu.latestGrade()?.gradeNumerator ?? '-').toString(),
          gradeDenominator:
              (tu.latestGrade()?.gradeDenominator ?? '-').toString(),
          forceGreen: forceGreen,
          isSeen: tu.isSeen,
          onTap: (tu) => onClick(tu),
        ));
  }
}

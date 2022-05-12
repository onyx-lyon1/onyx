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
    return GestureDetector(
        onTap: () => onClick(tu),
        child: widgets.Card(
          text1: tu.name,
          text2: "${tu.mastersShort()} • grp ?",
          gradeNumerator: (tu.latestGrade()?.gradeNumerator ?? '-').toString(),
          gradeDenominator:
              (tu.latestGrade()?.gradeDenominator ?? '-').toString(),
          forceGreen: forceGreen,
          isSeen: tu.isSeen,
        ));
  }
}

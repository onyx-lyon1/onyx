import 'package:flutter/material.dart';
import 'package:oloid2/widget/card.dart' as grade;

class TeachingUnit extends StatelessWidget {
  final String gradeNumerator;
  final String gradeDenominator;
  final String ueName;
  final String teacher;
  final String group;
  final bool isSeen;
  final bool forceGreen;

  final Function(String id) onClick;

  const TeachingUnit({
    Key? key,
    required this.ueName,
    required this.gradeNumerator,
    required this.gradeDenominator,
    required this.teacher,
    required this.group,
    required this.isSeen,
    required this.forceGreen,
    required this.onClick,
  }) : super(key: key);

  // "$teacher • grp $group"
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onClick('some id'),
        child: grade.Card(
          text1: ueName,
          text2: "$teacher • grp $group",
          gradeNumerator: gradeNumerator,
          gradeDenominator: gradeDenominator,
          forceGreen: forceGreen,
          isSeen: isSeen,
        ));
  }
}

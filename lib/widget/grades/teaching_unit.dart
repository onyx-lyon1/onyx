import 'package:flutter/material.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/widget/card.dart' as widgets;

class TeachingUnit extends StatelessWidget {
  final TeachingUnitModel tu;
  final bool forceGreen;
  final int id;
  final Function(int id) onClick;

  const TeachingUnit({
    Key? key,
    required this.tu,
    required this.id,
    required this.forceGreen,
    required this.onClick,
  }) : super(key: key);

  // "$teacher • grp $group"
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onClick(id),
        child: widgets.Card(
          text1: tu.name,
          text2: "${tu.mastersShort()} • grp ?",
          gradeNumerator: '',
          gradeDenominator: 'gradeDenominator',
          forceGreen: forceGreen,
          isSeen: false,
        ));
  }
}

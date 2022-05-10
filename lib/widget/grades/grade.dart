import 'package:flutter/widgets.dart';
import 'package:oloid2/widget/card.dart';
import '../../model/grade.dart';

class Grade extends StatelessWidget {
  final GradeModel gradeModel;
  final bool forceGreen;

  const Grade({
    Key? key,
    required this.gradeModel,
    required this.forceGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      text1: gradeModel.name,
      text2:
          "${gradeModel.average.toStringAsFixed(2)} • ${gradeModel.mediane.toStringAsFixed(2)} • ${gradeModel.author}",
      gradeNumerator: gradeModel.gradeNumerator.toString(),
      gradeDenominator: gradeModel.gradeDenominator.toString(),
      forceGreen: forceGreen,
      isSeen: gradeModel.isSeen,
    );
  }
}

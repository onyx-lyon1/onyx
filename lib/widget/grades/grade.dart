import 'package:flutter/widgets.dart';
import 'package:oloid2/widget/card.dart';
import '../../model/grade_model.dart';

class Grade extends StatelessWidget {
  final GradeModel gradeModel;
  final bool forceGreen;
  final Function(GradeModel grade) onTap;

  const Grade({
    Key? key,
    required this.gradeModel,
    required this.forceGreen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      o: gradeModel,
      groupeSize: 120,//TODO implement groupe size
      rank: gradeModel.rank,
      text1: gradeModel.name,
      text2:
          "${gradeModel.average.toStringAsFixed(2)} • ${gradeModel.mediane.toStringAsFixed(2)} • ${gradeModel.author}",
      gradeNumerator: gradeModel.gradeNumerator.toString(),
      gradeDenominator: gradeModel.gradeDenominator.toString(),
      forceGreen: forceGreen,
      isSeen: true,
      onTap: (gradeModel) => onTap(gradeModel),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/model/grade.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/widget/grades/grade_list_header.dart';
import 'package:oloid2/widget/grades/teaching_unit.dart';
import '../widget/grades/grade.dart';

class TeachingUnits extends StatelessWidget {
  final List<TeachingUnitModel> teachingUnits;
  final Function() onRefresh;
  final bool forceGreen;

  const TeachingUnits({
    Key? key,
    required this.teachingUnits,
    required this.onRefresh,
    required this.forceGreen,
  }) : super(key: key);

  void showAllGrades(BuildContext context, int id) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const GradeListHeader(),
              ...teachingUnits[id].grades.map(
                    (e) => Grade(
                      gradeModel:
                          GradeModel.fromGrade(e, teachingUnits[id].isSeen),
                      forceGreen: forceGreen,
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ...teachingUnits.map(
                (e) => TeachingUnit(
                    tu: e, id: 0, forceGreen: forceGreen, onClick: (int id) {}),
              )
              // TeachingUnit(
              //   ueName: 'Nom de l\'UE',
              //   gradeNumerator: '15',
              //   gradeDenominator: '20',
              //   teacher: 'Nom de l\'enseignant',
              //   group: 'GRP',
              //   isSeen: false, // TODO
              //   forceGreen: false, // TODO
              //   onClick: (int id) => showAllGrades(context, id),
              // ),
            ],
          ),
          onRefresh: () async => await onRefresh(),
        ));
  }
}

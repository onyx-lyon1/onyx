import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/model/teaching_unit.dart';
import 'package:oloid2/widget/grades/grade_list_header.dart';
import 'package:oloid2/widget/grades/teaching_unit.dart';
import '../widget/grades/grade.dart';

class TeachingUnitsPage extends StatelessWidget {
  final List<TeachingUnitModel> teachingUnits;
  final Function() onRefresh;
  final bool forceGreen;
  final bool showHidden;

  const TeachingUnitsPage({
    Key? key,
    required this.teachingUnits,
    required this.onRefresh,
    required this.forceGreen,
    required this.showHidden,
  }) : super(key: key);

  void showAllGrades(BuildContext context, TeachingUnitModel tu) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                GradeListHeader(
                  tu: tu,
                ),
                ...tu.grades.map(
                  (e) => Grade(
                    gradeModel: e,
                    forceGreen: forceGreen,
                    onTap: (e) {
                      print('Tapped on grade ${e.name}');
                    },
                  ),
                ),
              ],
            ),
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
              ...teachingUnits
                  .where((element) => element.isHidden == false || showHidden)
                  .map(
                    (e) => TeachingUnit(
                      tu: e,
                      forceGreen: forceGreen,
                      onClick: (TeachingUnitModel tu) {
                        print('Tapped on teaching unit ${tu.name}');
                        showAllGrades(context, tu);
                      },
                    ),
                  )
            ],
          ),
          onRefresh: () async => await onRefresh(),
        ));
  }
}

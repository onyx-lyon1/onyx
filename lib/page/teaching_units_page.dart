import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oloid2/widget/grade_list.dart';
import 'package:oloid2/widget/teaching_unit.dart';
import 'package:oloid2/widget/widgets.dart' as w;

class TeachingUnits extends StatelessWidget {
  final List<TeachingUnits> teachingUnits;
  final Function() onRefresh;

  const TeachingUnits({
    Key? key,
    required this.teachingUnits,
    required this.onRefresh,
  }) : super(key: key);

  void showAllGrades(BuildContext context, String id) {
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
              Text('HEADER'), // TODO
              TeachingUnit(
                ueName: 'Nom de l\'UE',
                gradeNumerator: '15',
                gradeDenominator: '20',
                teacher: 'Nom de l\'enseignant',
                group: 'GRP',
                isSeen: false, // TODO
                forceGreen: false, // TODO
                onClick: (String id) => showAllGrades(context, id),
              ),
              TeachingUnit(
                ueName: 'Nom de l\'UE',
                gradeNumerator: '15',
                gradeDenominator: '20',
                teacher: 'Nom de l\'enseignant',
                group: 'GRP',
                isSeen: false, // TODO
                forceGreen: false, // TODO
                onClick: (String id) => showAllGrades(context, id),
              ),
              TeachingUnit(
                ueName: 'Nom de l\'UE',
                gradeNumerator: '15',
                gradeDenominator: '20',
                teacher: 'Nom de l\'enseignant',
                group: 'GRP',
                isSeen: false, // TODO
                forceGreen: false, // TODO
                onClick: (String id) => showAllGrades(context, id),
              ),
            ],
          ),
        ),
      ),
    );

    // showStickyFlexibleBottomSheet(
    //   minHeight: 0,
    //   initHeight: 0.5,
    //   maxHeight: 1,
    //   headerHeight: 30,
    //   context: context,
    //   headerBuilder: (BuildContext context, double offset) {
    //     return Container(
    //       height: 30,
    //       clipBehavior: Clip.hardEdge,
    //       decoration: BoxDexcoration(
    //         color: Theme.of(context).backgroundColor,
    //       ),
    //       child: Container(
    //         height: 3,
    //         width: 50,
    //         decoration: const BoxDecoration(color: Colors.red),
    //       ),
    //     );
    //   },
    //   bodyBuilder: (BuildContext context, double offset) {
    //     return SliverChildListDelegate([]);
    //   },
    //   isSafeArea: true,
    // );

    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext ctxt) {
    //     return GradeList();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: RefreshIndicator(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              TeachingUnit(
                ueName: 'Nom de l\'UE',
                gradeNumerator: '15',
                gradeDenominator: '20',
                teacher: 'Nom de l\'enseignant',
                group: 'GRP',
                isSeen: false, // TODO
                forceGreen: false, // TODO
                onClick: (String id) => showAllGrades(context, id),
              ),
              TeachingUnit(
                ueName: 'Nom de l\'UE',
                gradeNumerator: '15',
                gradeDenominator: '20',
                teacher: 'Nom de l\'enseignant',
                group: 'GRP',
                isSeen: true, // TODO
                forceGreen: false, // TODO
                onClick: (String id) => showAllGrades(context, id),
              ),
            ],
          ),
          onRefresh: () async => await onRefresh(),
        ));
  }
}
